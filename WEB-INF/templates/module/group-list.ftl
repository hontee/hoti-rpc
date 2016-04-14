<div class="container">
  <div class="card-columns">
    <#list groups as g>
    <div class="card">
      <a href="/groups/${g.id}">
        <blockquote class="card-block">
          <h3 class="card-title">${g.title!}</h3>
          <p class="card-text">${g.description!}</p>
          <footer>
            <small class="text-muted"><span data-follow="star">${g.star}</span>人关注</small> ·
            <small class="text-muted">${g.count}个站点</small>
          </footer>
        </blockquote>
      </a>
      <#if g.follow==1>
      <footer class="card-footer" data-follow="follow" data-href="/groups/${g.id}/unfollow">取消关注</footer>
      <#else>
      <footer class="card-footer" data-follow="follow" data-href="/groups/${g.id}/follow">关注</footer>
      </#if>
    </div>
    </#list>
  </div>
</div>

