$("#search-results").replaceWith("<%= escape_javascript(render(:partial => 'projects/search_results', locals: {projects: @projects })) %>");
