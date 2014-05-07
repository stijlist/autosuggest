# autosuggestions: take a set of strings, see if the input string is
# a completion of any of these

require_relative('../lib/autosuggest.rb')

describe Autosuggest do
  let(:coloropts) { {input: :red, completion: :gray} }

  context "given an empty completion set" do
    let(:cset) { Set.new }
    it "should return an unmodified version of the input" do
      Autosuggest.suggest("hello", cset).should == "hello"
    end

    context "given an input and completion color" do
      it "colors the input substring to match that input color" do
        Autosuggest.suggest("hello", cset, coloropts)
                   .should == "hello".colorize(:red)
      end
    end
  end

  context "given a non-empty completion set" do
    let(:cset) { Set.new(["hello"]) }

    it "returns a completion if the input is a prefix of a completion in the set" do
      Autosuggest.suggest("hel", cset).should == "hello"
    end

    context "given an input and completion color" do
      it "colors the completion substring to match the completion color" do
        Autosuggest.suggest("hel", cset, coloropts)
                   .should == "hel".colorize(:red) << "lo".colorize(:gray)
      end
    end
  end

  context "given a completion set with repeated substring matches of the input" do
    let(:cset) { Set.new(["hello hello"]) }
    it "only colorizes the first matched substring" do
      Autosuggest.suggest("hel", cset, coloropts)
                 .should == "hel".colorize(:red) << "lo hello".colorize(:gray)
    end
  end
end
