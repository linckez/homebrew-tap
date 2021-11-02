class Sqlcl < Formula
  desc "Oracle SQLcl, Oracle SQL Developer Command Line (SQLcl) is a free command line interface for Oracle Database. It allows you to interactively or batch execute SQL and PL/SQL. SQLcl provides in-line editing, statement completion, and command recall for a feature-rich experience, all while also supporting your previously written SQL*Plus scripts."
  homepage "https://www.oracle.com/database/technologies/appdev/sqlcl.html"
  url "https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip"
  sha256 "96f6b2bacd8811b07f2aa88ef622111a91982914ff87ba19676ffbf66b87dc17"
  version "21.3.1.281.1748"

  resource "sqlcl" do
    url "https://download.oracle.com/otn_software/java/sqldeveloper/sqlcl-latest.zip"
    sha256 "96f6b2bacd8811b07f2aa88ef622111a91982914ff87ba19676ffbf66b87dc17"
  end

  bottle :unneeded

  depends_on arch: :x86_64
  depends_on macos: :high_sierra

  def install
    buildpath.install resource("sqlcl")

    # Remove Windows files
    rm_f "bin/sql.exe"

    # Remove Other files
    rm_f "bin/README.md"
    rm_f "bin/dependencies.txt"
    rm_f "bin/version.txt"
    rm_f "lib/pom.xml"

    # Install
    bin.install "bin/sql" => "sql"
    libexec.install "lib"
    bin.env_script_all_files(libexec/"bin", JAVA_HOME: Formula["openjdk"].opt_prefix)

  end

  test do
    system bin/"sql", "-V"
  end
end
