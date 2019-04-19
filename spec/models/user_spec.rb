require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validation" do
    describe "national_id" do
      context "when national_id length is less than 14" do
        it "add a validation error" do
          subject.national_id = 123456789
          subject.valid?
          expect(subject.errors[:national_id])
        end
      end
    end
    describe "first_name" do
      context "when first_name has no value " do
        it "add a validation error" do
          subject.first_name = ""
          subject.valid?
          expect(subject.errors[:first_name])
        end
      end
    end
    describe "last_name" do
      context "when last_name has no value " do
        it "add a validation error" do
          subject.last_name = ""
          subject.valid?
          expect(subject.errors[:last_name])
        end
      end
    end
    describe "password" do
      context "when password has no value " do
        it "add a password error" do
          subject.password = ""
          subject.valid?
          expect(subject.errors[:password])
        end
      end
    end
  end
  describe '#full_name'  do           #
    context 'when user has a first name and last name' do  # (almost) plain English
      it 'returns space sperator between first and last name' do   #
        user = User.new first_name: 'Alaa', last_name: 'Tarek'

        expect(user.full_name).to eq 'Alaa Tarek' # test code
      end
    end
    context 'when user has a first name only' do  # (almost) plain English
      it 'returns nill' do   #
        user = User.new first_name: 'Alaa'

        expect(user.full_name).to eq '' # test code
      end
    end


  end

  describe '#birthdate'  do           #
    context 'when user has a national id number ' do  # (almost) plain English
      it 'returns date from national id number' do   #
        user = User.new national_id: 29504032354678

        expect(user.birth_date).to eq '03/04/1995' # test code
      end
    end

  end

  describe '#age'  do           #
    context 'when user has a national id number' do  # (almost) plain English
      it 'returns age' do   #
        allow(subject).to receive(:birth_date). and_return "03/04/1995"
          expect(subject.age ).to eq 24

      end
    end

  end

  describe '#gender'  do           #
    context 'when user has a national id number ' do  # (almost) plain English
      it 'returns gender type male when gender flag is not 0' do   #
        user = User.new national_id: 29504032354678

        expect(user.gender).to eq "Male" # test code
      end
    end

    context 'when user has a national id number ' do  # (almost) plain English
      it 'returns gender type female when gender flag is 0' do   #
        user = User.new national_id: 29504032102562

        expect(user.gender).to eq "Female" # test code
      end
    end
    context 'when user id female ' do  # (almost) plain English
        context 'when user = female' do

        it 'returns true' do   #
          allow(subject).to receive(:gender). and_return "Female"
          expect(subject.gender? 'Female').to be true

        end
      end
    end

    context 'when user id female ' do  # (almost) plain English
        context 'when user = female' do

        it 'returns true' do   #
          allow(subject).to receive(:gender). and_return "Female"
          expect(subject.gender? 'Female').to be true

        end
      end
    end
    

  end
  describe "#register" do
    context 'when user is registeder ' do  # (almost) plain English

      it 'update password a new Object' do
        allow(subject).to receive(:password). and_return "8aa40001b9b39cb257fe646a561a80840c806c55"
        subject.register
          expect(subject.password ).to eq "8aa40001b9b39cb257fe646a561a80840c806c55"
      end
    end
  end

  describe ".hashed_password" do
    context 'when password is encypted' do  # (almost) plain English

      it 'returns hash' do
          expect(User.hashed_password  "lolo").to eq "8aa40001b9b39cb257fe646a561a80840c806c55"
      end
    end
  end
  describe ".login" do

  context 'when user enterd invalid data' do  # (almost) plain English

    it 'returns false' do
      
        expect(User.login 29504031122300 , "lo").to be false
    end
    
  end
 

  context 'user enters national id and password ' do
      it 'returns specific user' do
     user = User.create!({:first_name =>"alaa",:last_name=>"tarek",:national_id=>"12345678912341" ,:password=>"lolo"})
      expect(User.login("12345678912341","lolo")).equal?(user)
    end
  end
  end


end

