class CfrDecompiler < Formula
  desc "Yet Another Java Decompiler"
  homepage "https://www.benf.org/other/cfr/"
  url "https://www.benf.org/other/cfr/cfr-0.148.jar"
  sha256 "1407f91fe7f94ff700cc1c8d546986a3fc2554273f07bae664bd58b0d85fd012"

  bottle :unneeded

  depends_on :java => "1.6+"

  def install
    libexec.install "cfr-#{version}.jar"
    bin.write_jar_script libexec/"cfr-#{version}.jar", "cfr-decompiler"
  end

  test do
    fixture = <<~EOS
      import java.io.PrintStream;

      class T {
          T() {
          }

          public static void main(String[] arrstring) {
              System.out.println("Hello brew!");
          }
      }
    EOS
    (testpath/"T.java").write fixture
    system "javac", "T.java"
    output = pipe_output("#{bin}/cfr-decompiler T.class")
    assert_match fixture, output
  end
end
