/* 
================================================================================
檔案代號:logi_t
檔案名稱:使用者登入紀錄表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table logi_t
(
logient       number(5)      ,/* 企業編號 */
logi001       varchar2(20)      ,/* 使用者編號 */
logi002       timestamp(0)      ,/* 時間 */
logi003       varchar2(20)      ,/* 登入IP */
logi004       varchar2(20)      ,/* 主機IP */
logi005       varchar2(40)      ,/* 動作說明 */
logi006       varchar2(1)      ,/* 成功或失敗 */
logiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
logiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
logiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
logiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
logiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
logiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
logiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
logiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
logiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
logiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
logiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
logiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
logiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
logiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
logiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
logiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
logiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
logiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
logiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
logiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
logiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
logiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
logiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
logiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
logiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
logiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
logiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
logiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
logiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
logiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);


grant select on logi_t to tiptop;
grant update on logi_t to tiptop;
grant delete on logi_t to tiptop;
grant insert on logi_t to tiptop;

exit;
