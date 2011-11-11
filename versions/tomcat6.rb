require 'formula'

class Tomcat6 <Formula
  url 'http://archive.apache.org/dist/tomcat/tomcat-6/v6.0.32/bin/apache-tomcat-6.0.32.tar.gz'
  homepage 'http://tomcat.apache.org/'
  md5 '928a960268adf610a7d6fe5c4fcd0b20'

  skip_clean :all

  keg_only "Some scripts that are installed conflict with other software."

  def install
    rm_rf Dir['bin/*.{cmd,bat]}']
    libexec.install Dir['*']
    (libexec+'logs').mkpath
    bin.mkpath
    Dir["#{libexec}/bin/*.sh"].each { |f| ln_s f, bin }
  end

  def caveats; <<-EOS.undent
    Note: Some of the support scripts used by Tomcat have very generic names.
    These are likely to conflict with support scripts used by other Java-based
    server software.

    You may want to `brew unlink tomcat` and add:
      #{bin}
    to your PATH instead.
    EOS
  end
end
