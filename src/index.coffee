moduleName = 'rs-pagination'
module.exports = (config) ->
  angular = window.angular or require 'angular'
  angular.module moduleName, []
  .directive 'pagination', ->
    restrict: 'AE'
    require: 'ngModel'
    template: require './template.html'
    replace: true
    scope:
      ngModel: '='
      pageSize: '='
      total: '='
      showFirstLast: '='
      firstText: '@'
      lastText: '@'
      showAllPages: '='
      pagesToShow: '='
      hidePrevNext: '='
      prevText: '@'
      nextText: '@'
      ellipsisText: '@'
      pageChange: '&'
    link: (scope, elem) ->
      scope.totalPages = 0
      scope.getPages = ->
        scope.firstText = scope.firstText or 'First'
        scope.lastText = scope.lastText or 'Last'
        scope.prevText = scope.prevText or '<<'
        scope.nextText = scope.nextText or '>>'
        scope.ellipsisText = scope.ellipsisText or '..'
        pages = []
        pagesToShow = scope.pagesToShow or 5
        i = Math.max 0, scope.ngModel - Math.ceil(pagesToShow / 2)
        end = i + pagesToShow
        scope.totalPages = Math.ceil scope.total / scope.pageSize
        if end > scope.totalPages
          end = scope.totalPages
          i = Math.max 0, end - pagesToShow
        scope.ellipsisPre = false
        if i > 0
          scope.ellipsisPre = true
        scope.ellipsisPost = false
        if i + pagesToShow < scope.totalPages
          scope.ellipsisPost = true
        while i++ < Math.min scope.totalPages, end
          pages.push i
        if scope.ngModel > scope.totalPages
          scope.ngModel = 1
        pages
      scope.setPage = (page) ->
        scope.ngModel = page
        scope.pageChange?()? page
  moduleName