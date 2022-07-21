rule target:
    input:
        touch("build_complete.txt")

rule blogdown:
    output:
        touch("blogdown_complete.txt")
    shell:
        """
        Rscript -e 'blogdown::build_site()'
        """

rule post_process_blogdown:
    input:
        "blogdown_complete.txt"
    output:
        touch("post_process_blogdown_complete.txt")
    script:
        "scripts/post_process_blogdown.R"

rule run_hugo:
    input:
        "post_process_blogdown_complete.txt"
    output:
        touch("build_complete.txt")
    shell:
        "hugo"