# frozen_string_literal: true

describe file('/usr/local/bin/commitlint') do
  it { should exist }
end

describe command('commitlint --version') do
  its('exit_status') { should eq 0 }
  its('stderr') { should eq '' }
  its('stdout') { should match input('CL_CLI_VERSION') }
end

describe command('echo "feat: message" | commitlint') do
  its('exit_status') { should eq 0 }
  its('stderr') { should eq '' }
  its('stdout') { should eq '' }
end
