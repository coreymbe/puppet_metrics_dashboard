require 'spec_helper_acceptance'

describe 'puppet_metrics_dashboard class' do
  context 'init with default parameters' do
    it 'installs grafana and influxdb' do
      pp = <<-MANIFEST
        include puppet_metrics_dashboard
        MANIFEST

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).not_to eq(1)
      expect(apply_manifest(pp).exit_code).not_to eq(1)
      idempotent_apply(pp)
    end
    describe port('3000') do
      it { is_expected.to be_listening }
    end

    # Influxdb should be listening on port 8086 by default
    describe port('8086') do
      it { is_expected.to be_listening }
    end
  end
end
