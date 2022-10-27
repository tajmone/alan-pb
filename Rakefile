# "Rakefile" v0.5.0 | 2022/10/29 | by Tristano Ajmone

require './_assets/rake/globals.rb'
require './_assets/rake/asciidoc.rb'

# @WARNING -- Since the introduction of the code that generates the dump and
# summary files, the ':demos' task is leaving behind the temporary '.dat' and
# '.tmp' compiler files. These were present even when invoking the compiler
# with the redirection operator '>', instead of handling the creation of the
# summary file manually, so it's probably due to the file renaming operations
# happening too fast and interfering with file access permissions.
# Currently, the workaround was to add ':CLEAN' to the default task, but a
# proper solution is needed. Maybe I could add some code to AlanCompile() to
# check for the presence of these temp files and delete them if found, either
# after or before compiling.

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
  if !opts then
    # Generate dump (.lis) and summary (.sum) files only when compiling
    # an adventure in "plain mode" (without DBG or PACK options).
    opts = "-listing -height 0 -dump ! -summary"
    summary = true
  end
  begin
    alan_cmd = "alan #{adv_src} #{opts}"
    puts alan_cmd
    alan_stdout, alan_stderr, alan_status = Open3.capture3(alan_cmd)
    raise unless alan_status.success?
  rescue
    our_msg = "The ALAN compiler reported the following errors."
    PrintTaskFailureMessage(our_msg, alan_stdout) # ALAN logs errors on stdout!
    # Abort Rake execution with error description:
    raise "ALAN compilation failed: #{t.source}"
  else
    # If "plain mode" compilation went well, deal with summary file...
    begin
      if summary
        sum_fname = adv_src.ext('.sum')
        sum_file = File.open(sum_fname, "w")
        sum_file.write(alan_stdout)
      end
    rescue StandardError => e
      our_msg = "Unable to create compiler summary file."
      PrintTaskFailureMessage(our_msg, e)
      # Abort Rake execution with error description:
      raise "ALAN compiler summary file failed: #{sum_fname}"
    end
  ensure
    cd $repo_root, verbose: false
  end
end

# ==============================================================================
# -------------------------------{  T A S K S  }--------------------------------
# ==============================================================================

# @NOTE: The :clean task was added to get rid of the temporary '.dat' and '.tmp'
#        files left over after compiling the :demos adventures.

task :default => [:demos, :docs, :clean]

## Clean & Clobber
##################
require 'rake/clean'
CLEAN.include('**/*.dat',
              '**/*.tmp')
CLOBBER.include('**/*.a3c',
                '**/*.a3r',
                '**/*.ifid',
                '**/*.lis',
                '**/*.log',
                '**/*.sav',
                '**/*.sum',
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
task :docs => [:clock, :pbdoc]

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

SHARED_DEPS = FileList['docs-src/_shared/*.adoc']

## Docs: ARun Clockwork
#######################

desc "Docs: ARun Clockwork"
task :clock => 'docs/ARun-Clockwork.html'

CLOCK_DEPS = FileList['docs-src/clockwork/*.{asciidoc,adoc}']

file 'docs/ARun-Clockwork.html' => [*CLOCK_DEPS, *SHARED_DEPS] do
  AsciidoctorConvert('docs-src/clockwork/ARun-Clockwork.asciidoc', ADOC_OPTS)
end

## Docs: ARun PureBasic
#######################

desc "Docs: ARun PureBasic"
task :pbdoc => 'docs/ARun-PureBasic.html'

PBDOC_DEPS = FileList['docs-src/purebasic/*.{asciidoc,adoc}']

file 'docs/ARun-PureBasic.html' => [*PBDOC_DEPS, *SHARED_DEPS] do
  AsciidoctorConvert('docs-src/purebasic/ARun-PureBasic.asciidoc', ADOC_OPTS)
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
#  * <adventure>.[a3c/a3r]       -> simple (no DBG nor PACK options)
#
# When invoked without options ("plain mode") the AlanCompile() function will
# also generate a dump listing (.lis) and a compilation summary (.sum) file.

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
