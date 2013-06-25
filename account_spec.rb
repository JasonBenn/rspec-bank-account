require "rspec"

require_relative "account"

describe Account do
  let(:account) { Account.new('1234567890') }

  describe "#initialize" do
    it "should only accept 10 digit number strings" do
      expect(account).to be_an_instance_of Account
    end
    it "should not accept short number strings (shorter than length 10)" do
      lambda { Account.new('23423552435245') }.should raise_error(InvalidAccountNumberError)
    end
    it "should not accept long number strings (greater than length 10)" do
      lambda { Account.new('2342355') }.should raise_error(InvalidAccountNumberError)
    end
    it "should not accept number input" do
      lambda { Account.new(2342355) }.should raise_error(NoMethodError)
    end
  end

  describe "#transactions" do
    it "should be in the form of an array" do
      account.transactions.should be_an_instance_of Array
    end
  end

  describe "#account_number" do
    it "should have obscured account number" do
      expect(account.acct_number).to eq('******7890')
    end
  end

  describe "deposit!" do
    it "should be a positive number" do
      lambda {account.deposit!(-100)}.should raise_error
    end

    it "should return an increased balance" do
      expect { account.deposit!(100) }.to change(account, :balance).by(100)
    end

  end

  describe "#balance" do
    it "should properly sum all transactions" do
      account.stub(:transactions => [40, 60])
      expect(account.balance).to equal(100)
    end
  end

  describe "#withdraw!" do
    it "should reduce account balance" do
      account.stub(:transactions => [100])
      balance = account.withdraw! 50
      expect(balance).to equal(50)
    end
  end
end

