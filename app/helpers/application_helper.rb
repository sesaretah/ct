module ApplicationHelper
  def sexs
    @options = [
      [t(:male), t(:male)],
      [t(:female) , t(:female)]
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

  def gtypes
    @options = [
      [t(:open), 1],
      [t(:closed) , 2]
    ]
    return @options
  end

  def itypes
    @options = [
      [t(:need_approval), 1],
      [t(:dont_need_approval) , 2]
    ]
    return @options
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
