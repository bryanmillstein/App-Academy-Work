Autotest.add_discovery { "rails" }
Autotest.add_discovery { "rspec2" }

Autotest.add_hook :initialize do |autotest| autotest.add_mapping(/ˆspec\/requests\/.*_spec\.rb$/) do
    autotest.files_matching(/ˆspec\/requests\/.*_spec\.rb$/)
 end
end
