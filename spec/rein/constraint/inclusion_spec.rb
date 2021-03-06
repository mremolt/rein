require 'spec_helper'

describe RC::Inclusion, "#add_inclusion_constraint" do
  let(:adapter) do
    Class.new do
      include RC::Inclusion
    end.new
  end

  subject { adapter }

  before do
    stub(adapter).execute
  end

  context "given an array of string values" do
    before { adapter.add_inclusion_constraint(:books, :state, :in => %w(available on_loan)) }
    it { should have_received.execute("ALTER TABLE books ADD CONSTRAINT books_state CHECK (state IN ('available', 'on_loan'))") }
  end

  context "given an array of numeric values" do
    before { adapter.add_inclusion_constraint(:books, :state, :in => [1, 2, 3]) }
    it { should have_received.execute("ALTER TABLE books ADD CONSTRAINT books_state CHECK (state IN (1, 2, 3))") }
  end
end
