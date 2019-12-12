import os
import sys
from subprocess import *


class quality_control():

    # def __init__(self):
    #     self.fastq_dir = "/home/rzli/fish/1/"
    #     self.Trimmomatic = "/home/rzli/biosoft/Trimmomatic/Trimmomatic-0.38/trimmomatic-0.38_jar"
    #     self.outputDir = "/home/rzli/fish/trimmoResult/"
    #     self.adaptor = "/home/rzli/biosoft/Trimmomatic/Trimmomatic-0.38/adapters/TruSeq2-PE.fa"

    def run(self, cmd=None, wkdir=None):
        sys.stderr.write("Running %s ...\n" % cmd)
        p = Popen(cmd, shell=True, cwd=wkdir)
        p.wait()
        return p

    def test(self, inputfile=None, outputDir=None):
        fileName = os.path.basename(inputfile)
        outputfile = os.path.join(outputDir, fileName.replace("m.bam", "0.5_m.bam"))
        cmd ="samtools view -s 0.5 -bo %s %s" % (outputfile,inputfile)
        return cmd

if __name__ == "__main__":
    qc = quality_control()
    inputfile = "/home/rzli/swxxxjz/bam/10/m.bam"
    cmd = qc.test(inputfile=inputfile, outputDir="/home/rzli/test/")
    qc.run(cmd=cmd)
