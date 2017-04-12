module ApplicationHelper
  require 'securerandom'

  def policytypes
    @options = [
      [t(:everyone), 1],
      [t(:only_followers) , 2],
      [t(:only_me) , 3]
    ]
    return @options
  end

  def sexs
    @options = [
      [t(:male), t(:male)],
      [t(:female) , t(:female)]
    ]
    return @options
  end

  def rstatus(s)
    @options = [t(:running),t(:scheduled),t(:stoped),t(:ended), t(:waiting)]
    return @options[s-1]
  end

  def erstatus(s)
    @options = ['running','scheduled','stoped','ended', 'waiting']
    return @options[s-1]
  end

  def status
    @options = [
      [t(:running), 1],
      [t(:scheduled) , 2],
      [t(:stoped) , 3],
      [t(:ended) , 4],
      [t(:waiting) , 5]
    ]
    return @options
  end
  def project_types
    @options = [
      [t(:bonyadi), t(:bonyadi)],
      [t(:karbordi), t(:karbordi)],
      [t(:tosei), t(:tosei)],
      [t(:rahbordi) , t(:rahbordi)]
    ]
    return @options
  end
  def ptypes
    @options = [
      [t(:private), 1],
      [t(:public) , 2]
    ]
    return @options
  end

  def rptypes(p)
    @options = [t(:private),t(:public)]
    return @options[p-1]
  end

  def gtypes
    @options = [
      [t(:open), 1],
      [t(:closed) , 2]
    ]
    return @options
  end

  def rgtypes(g)
    @options = [t(:open),t(:closed)]
    return @options[g-1]
  end

  def itypes
    @options = [
      [t(:need_approval), 1],
      [t(:dont_need_approval) , 2]
    ]
    return @options
  end

  def ritypes(i)
    @options = [t(:need_approval),t(:dont_need_approval)]
    return @options[i-1]
  end

  def grades
    @options = [
      #  [t(:primary), t(:primary)],
      #  [t(:middle) , t(:middle)],
      [t(:high), t(:high)],
      [t(:bs), t(:bs)],
      [t(:ms), t(:ms)],
      [t(:phd), t(:phd)],
      [t(:postdoc), t(:postdoc)]
    ]
    return @options
  end
  def paginate(collection, params= {})
    will_paginate collection, params.merge(:renderer => RemoteLinkPaginationHelper::LinkRenderer)
  end

  def public?(c)
    if !c.blank?
      if  c.p_type == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def global?(c)
    if !c.blank?
      if  c.g_type == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def admin?(c)
    if !c.blank?
      if c.role == 1
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
