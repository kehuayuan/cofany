<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript">
	$.Event.prototype.getTarget = function(selector) {
		var obj = $(this.target).closest(selector);
		return obj[0] ? obj : null;
	};
	function table_row_select(table, rowSelector, rowSelCls) {
		rowSelector = rowSelector || 'tr';
		rowSelCls = rowSelCls || 'selected';

		var selected = null;
		$(table).on('click', function(e) {
			var row = e.getTarget(rowSelector);
			if (row) {
				if (selected) {
					selected.removeClass(rowSelCls);
				}
				selected = row;
				selected.addClass(rowSelCls);
			}
		});
	}

	var cr_del_id = null;
	$(document).on('click', function(e) {
		var rel = e.getTarget('[rel]');
		if (rel) {
			if (rel.attr('rel') == 'back') {
				window.history.back(-1);
			}
		}

		var del_row = e.getTarget('.cr_del');
		if (del_row) {
			var id = e.getTarget('tr').attr('id');

			cr_del_id = id;
			$('#cr_del_confirm').modal('toggle');

		}
	});

	$(document).ready(function() {
		$('.cr_del_confirm').on('click', function() {
			$.ajax({
				url : 'doDelete?id=' + cr_del_id,
				success : function() {
					location.reload();
				}
			});
		});
	});
</script>

<div class="modal fade" id="cr_del_confirm" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title">你确认要删除这条记录吗？</h4>
			</div>
			<div class="modal-body">
				<button type="submit" class="btn btn-success cr_del_confirm">确认</button>
				<a class="btn btn-default close" rel="关闭">关闭</a>
			</div>
		</div>
	</div>
</div>
