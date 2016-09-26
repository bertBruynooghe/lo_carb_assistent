describe InsulinDose do
  describe 'validation' do
    describe '#insulins' do
      it 'should not be empty' do
        expect(InsulinDose.new).not_to be_valid
      end
    end
  end
end
