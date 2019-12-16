(function() {
  var moduleName;

  moduleName = 'rs-pagination';

  module.exports = function(config) {
    var angular;
    angular = window.angular || require('angular');
    angular.module(moduleName, []).directive('pagination', function() {
      return {
        restrict: 'AE',
        require: 'ngModel',
        template: require('./template.html'),
        replace: true,
        scope: {
          ngModel: '=',
          pageSize: '=',
          total: '=',
          showFirstLast: '=',
          firstText: '@',
          lastText: '@',
          showAllPages: '=',
          pagesToShow: '=',
          hidePrevNext: '=',
          prevText: '@',
          nextText: '@',
          ellipsisText: '@',
          pageChange: '&'
        },
        link: function(scope, elem) {
          scope.totalPages = 0;
          scope.getPages = function() {
            var end, i, pages, pagesToShow;
            scope.firstText = scope.firstText || 'First';
            scope.lastText = scope.lastText || 'Last';
            scope.prevText = scope.prevText || '<<';
            scope.nextText = scope.nextText || '>>';
            scope.ellipsisText = scope.ellipsisText || '..';
            pages = [];
            pagesToShow = scope.pagesToShow || 5;
            i = Math.max(0, scope.ngModel - Math.ceil(pagesToShow / 2));
            end = i + pagesToShow;
            scope.totalPages = Math.ceil(scope.total / scope.pageSize);
            if (end > scope.totalPages) {
              end = scope.totalPages;
              i = Math.max(0, end - pagesToShow);
            }
            scope.ellipsisPre = false;
            if (i > 0) {
              scope.ellipsisPre = true;
            }
            scope.ellipsisPost = false;
            if (i + pagesToShow < scope.totalPages) {
              scope.ellipsisPost = true;
            }
            while (i++ < Math.min(scope.totalPages, end)) {
              pages.push(i);
            }
            if (scope.ngModel > scope.totalPages) {
              scope.ngModel = 1;
            }
            return pages;
          };
          return scope.setPage = function(page) {
            var base;
            scope.ngModel = page;
            return typeof scope.pageChange === "function" ? typeof (base = scope.pageChange()) === "function" ? base(page) : void 0 : void 0;
          };
        }
      };
    });
    return moduleName;
  };

}).call(this);

//# sourceMappingURL=index.js.map
