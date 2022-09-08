# "Rakefile" v0.3.0 | 2022/09/08 | by Tristano Ajmone

require './_assets/rake/globals.rb'
require './_assets/rake/asciidoc.rb'

# ==============================================================================
# --------------------{  P R O J E C T   S E T T I N G S  }---------------------
# ==============================================================================

ADOC_DIR = File.expand_path('_assets/adoc/')
DOCS_DIR = 'docs'
DOCS_DIR_ABS = File.expand_path(DOCS_DIR)

# ==============================================================================
# ------------------------{  R U B Y   M E T H O D S  }-------------------------
# ==============================================================================

require 'open3'

def AlanCompile(srcpath, opts=nil)
  adv_src = srcpath.pathmap("%f")
  adv_dir = srcpath.pathmap("%d")
  cd "#{$repo_root}/#{adv_dir}"
  begin
    alan_cmd = "alan #{opts} #{adv_src}"
    puts alan_cmd
    stdout, stderr, status = Open3.capture3(alan_cmd)
    raise unless status.success?
  rescue
    our_msg = "The ALAN compiler reported the following errors."
    PrintTaskFailureMessage(our_msg, stdout) # ALAN logs errors on stdout!
    # Abort Rake execution with error description:
    raise "ALAN compilation failed: #{t.source}"
  ensure
    cd $repo_root, verbose: false
  end
end

# ==============================================================================
# -------------------------------{  T A S K S  }--------------------------------
# ==============================================================================

task :default => [:demos, :docs]

## Clean & Clobber
##################
require 'rake/clean'
CLOBBER.include('**/*.a3c',
                '**/*.a3r',
                '**/*.ifid',
                '**/*.sav',
                'docs/*.html')

## Demo Adventures
##################

desc "Compile demo adventures"
task :demos

DEMOS = FileList['adventures/demos/*.alan'].each do |adv_src|
  adv_bin = adv_src.pathmap("%X") + ".a3c"
  task :demos => adv_bin
  file adv_bin => adv_src
end

## Documentation
################

desc "Build documentation"
task :docs => 'docs/ARun-Clockwork.html'

ADOC_OPTS = <<~HEREDOC
  --failure-level WARN \
  --verbose \
  --timings \
  --safe-mode unsafe \
  -r #{ADOC_DIR}/arun-src-linker.rb \
  -a source-highlighter=rouge \
  -a rouge-style=thankful_eyes \
  -a data-uri \
  -D #{DOCS_DIR_ABS}
HEREDOC

ADOC_DEPS = FileList['docs-src/*.{asciidoc,adoc}']

file 'docs/ARun-Clockwork.html' => ADOC_DEPS do
  AsciidoctorConvert('docs-src/ARun-Clockwork.asciidoc', ADOC_OPTS)
end

# ==============================================================================
# -------------------------------{  R U L E S  }--------------------------------
# ==============================================================================

## Compile ALAN Adventures
##########################

# For testing purposes, compile each adventure multiple times, using different
# options, then rename the generated storyfiles and resource files accordingly:
#
#  * <adventure>_DBG.[a3c/a3r]   -> option: -debug
#  * <adventure>_PACK.[a3c/a3r]  -> option: -pack
#  * <adventure>.[a3c/a3r]       -> no options

rule ".a3c" => ".alan" do |t|
  adv_src = t.source.pathmap("%f")
  adv_nox = t.source.pathmap("%X")
  adv_bin = adv_nox + '.a3c'
  adv_res = adv_nox + '.a3r'

  TaskHeader("Compiling: \"#{adv_src}\" w/ -DEBUG option")
  AlanCompile(t.source, "-debug")
  mv adv_bin, adv_nox + '_DBG.a3c'
  mv adv_res, adv_nox + '_DBG.a3r' if File.exist?(adv_res)

  TaskHeader("Compiling: \"#{adv_src}\" w/ -PACK option")
  AlanCompile(t.source, "-pack")
  mv adv_bin, adv_nox + '_PACK.a3c'
  mv adv_res, adv_nox + '_PACK.a3r' if File.exist?(adv_res)

  TaskHeader("Compiling: \"#{adv_src}\" without options")
  AlanCompile(t.source)
end
