module Populator
  # This module adds several methods for generating random data which can be
  # called directly on Populator.
  module Random
    WORDS = %w(alias consequatur aut perferendis sit voluptatem accusantium doloremque aperiam eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo aspernatur aut odit aut fugit sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt neque dolorem ipsum quia dolor sit amet consectetur adipisci velit sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem ut enim ad minima veniam quis nostrum exercitationem ullam corporis nemo enim ipsam voluptatem quia voluptas sit suscipit laboriosam nisi ut aliquid ex ea commodi consequatur quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae et iusto odio dignissimos ducimus qui blanditiis praesentium laudantium totam rem voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident sed ut perspiciatis unde omnis iste natus error similique sunt in culpa qui officia deserunt mollitia animi id est laborum et dolorum fuga et harum quidem rerum facilis est et expedita distinctio nam libero tempore cum soluta nobis est eligendi optio cumque nihil impedit quo porro quisquam est qui minus id quod maxime placeat facere possimus omnis voluptas assumenda est omnis dolor repellendus temporibus autem quibusdam et aut consequatur vel illum qui dolorem eum fugiat quo voluptas nulla pariatur at vero eos et accusamus officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae itaque earum rerum hic tenetur a sapiente delectus ut aut reiciendis voluptatibus maiores doloribus asperiores repellat)
    ADVERBS = %w(appropriately assertively authoritatively collaboratively compellingly competently completely continually conveniently credibly distinctively dramatically dynamically efficiently energistically enthusiastically globally holisticly interactively intrinsicly monotonectally objectively phosfluorescently proactively professionally progressively quickly rapidiously seamlessly synergistically uniquely)
    VERBS = %w(actualize administrate aggregate architect benchmark brand build communicate conceptualize coordinate create cultivate customize deliver deploy develop disintermediate disseminate drive embrace e-enable empower enable engage engineer enhance envisioneer evisculate evolve expedite exploit extend fabricate facilitate fashion formulate foster generate grow harness impact implement incentivize incubate initiate innovate integrate iterate leverage existing leverage others maintain matrix maximize mesh monetize morph myocardinate negotiate network optimize orchestrate parallel task plagiarize pontificate predominate procrastinate productivate productize promote provide access to pursue recaptiualize reconceptualize redefine re-engineer reintermediate reinvent repurpose restore revolutionize scale seize simplify strategize streamline supply syndicate synergize synthesize target transform transition underwhelm unleash utilize visualize whiteboard)
    ADJECTIVES = %w(accurate adaptive alternative an expanded array of B2B B2C backend backward-compatible best-of-breed bleeding-edge bricks-and-clicks business clicks-and-mortar client-based client-centered client-centric client-focused collaborative compelling  competitive cooperative corporate cost effective covalent cross functional cross-media cross-platform cross-unit customer directed customized cutting-edge distinctive distributed diverse dynamic e-business economically sound effective efficient emerging empowered enabled end-to-end enterprise enterprise-wide equity invested error-free ethical excellent exceptional extensible extensive flexible focused frictionless front-end fully researched fully tested functional functionalized future-proof global go forward goal-oriented granular high standards in high-payoff high-quality highly efficient holistic impactful inexpensive innovative installed base integrated interactive interdependent intermandated interoperable intuitive just in time leading-edge leveraged long-term high-impact low-risk high-yield magnetic maintainable market positioning market-driven mission-critical multidisciplinary multifunctional multimedia based next-generation one-to-one open-source optimal orthogonal out-of-the-box pandemic parallel performance based plug-and-play premier premium principle-centered proactive process-centric professional progressive prospective quality real-time reliable resource sucking resource maximizing resource-leveling revolutionary robust scalable seamless stand-alone standardized standards compliant state of the art sticky strategic superior sustainable synergistic tactical team building team driven technically sound timely top-line transparent turnkey ubiquitous unique user-centric user friendly value-added vertical viral virtual visionary web-enabled wireless world-class worldwide 2.0)
    NOUNS = %w(action items alignments applications architectures bandwidth benefits best practices catalysts for change channels collaboration and idea-sharing communities content convergence core competencies customer service data deliverables e-business e-commerce e-markets e-tailers e-services experiences expertise functionalities growth strategies human capital ideas imperatives infomediaries information infrastructures initiatives innovation intellectual capital interfaces internal or "organic" sources leadership leadership skills manufactured products markets materials meta-services methodologies methods of empowerment metrics mindshare models networks niches niche markets opportunities "outside the box" thinking outsourcing paradigms partnerships platforms portals potentialities process improvements processes products quality vectors relationships resources results ROI scenarios schemas services solutions sources strategic theme areas supply chains synergy systems technologies technology testing procedures total linkage users value vortals web-readiness web services)
    CONJUNCTIONS = %w(through via vis-a-vis with without and before after whereas for rather than)
    
    # Pick a random value out of a given range.
    def value_in_range(range)
      case range.first
      when Integer then number_in_range(range)
      when Time then time_in_range(range)
      when Date then date_in_range(range)
      else range.to_a.sample
      end
    end
    
    # Generate a readable sentence 
    def readable_sentences(total)
      (1..interpret_value(total)).map do
        ADVERBS.rand.capitalize + " " + [ VERBS.rand, ADJECTIVES.rand, NOUNS.rand, CONJUNCTIONS.rand, ADJECTIVES.rand, NOUNS.rand ].join(' ') + ". "
      end
    end
    
    # Generate a readable paragraph 
    def readable_paragraphs(total)
      (1..interpret_value(total)).map do
        readable_sentences(3..8).capitalize
      end.join("\n\n")
    end
    
    # Generate a given number of words. If a range is passed, it will generate
    # a random number of words within that range.
    def words(total)
      (1..interpret_value(total)).map { WORDS.sample }.join(' ')
    end
    
    # Generate a given number of sentences. If a range is passed, it will generate
    # a random number of sentences within that range.
    def sentences(total)
      (1..interpret_value(total)).map do
        words(5..20).capitalize
      end.join('. ')
    end
    
    # Generate a given number of paragraphs. If a range is passed, it will generate
    # a random number of paragraphs within that range.
    def paragraphs(total)
      (1..interpret_value(total)).map do
        sentences(3..8).capitalize
      end.join("\n\n")
    end
    
    # If an array or range is passed, a random value will be selected to match.
    # All other values are simply returned.
    def interpret_value(value)
      case value
      when Array then value.sample
      when Range then value_in_range(value)
      else value
      end
    end
    
    private
    
    def time_in_range(range)
      Time.at number_in_range(Range.new(range.first.to_i, range.last.to_i, range.exclude_end?))
    end
    
    def date_in_range(range)
      Date.jd number_in_range(Range.new(range.first.jd, range.last.jd, range.exclude_end?))
    end
    
    def number_in_range(range)
      if range.exclude_end?
        rand(range.last - range.first) + range.first
      else
        rand((range.last+1) - range.first) + range.first
      end
    end
  end
  
  extend Random # load it into the populator module directly so we can call the methods
end
