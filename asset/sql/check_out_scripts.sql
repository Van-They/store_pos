INSERT INTO order_head SELECT * FROM order_head_tmp;
INSERT INTO order_tran SELECT * FROM order_tran_tmp;
DELETE FROM order_head_tmp;
DELETE FROM order_tran_tmp
