require 'spec_helper'

describe TV do

  Dir[File.join(File.dirname(__FILE__), 'fixtures/**/*.yml')].each do |file|

    let File.basename(file, '.yml').to_sym do
      file
    end

    it "plays back a #{File.basename(file, '.yml').gsub /_/, ' '}" do
      TV.play(file)
    end

  end

end
