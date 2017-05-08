/* 
================================================================================
檔案代號:dead_t
檔案名稱:门店收银缴款出纳结账单头档
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dead_t
(
deadent       number(5)      ,/* 企業代碼 */
deadsite       varchar2(10)      ,/* 營運據點 */
deaddocno       varchar2(20)      ,/* 單號 */
deaddocdt       date      ,/* 單據日期 */
deadstamp       timestamp(5)      ,/* 時間戳記 */
dead001       varchar2(20)      ,/* 收銀員編號 */
deadownid       varchar2(20)      ,/* 資料所有者 */
deadowndp       varchar2(10)      ,/* 資料所屬部門 */
deadcrtid       varchar2(20)      ,/* 資料建立者 */
deadcrtdp       varchar2(10)      ,/* 資料建立部門 */
deadcrtdt       timestamp(0)      ,/* 資料創建日 */
deadmodid       varchar2(20)      ,/* 資料修改者 */
deadmoddt       timestamp(0)      ,/* 最近修改日 */
deadstus       varchar2(10)      ,/* 狀態碼 */
deadud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deadud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deadud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deadud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deadud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deadud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deadud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deadud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deadud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deadud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deadud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deadud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deadud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deadud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deadud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deadud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deadud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deadud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deadud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deadud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deadud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deadud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deadud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deadud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deadud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deadud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deadud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deadud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deadud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deadud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dead_t add constraint dead_pk primary key (deadent,deaddocno) enable validate;

create unique index dead_pk on dead_t (deadent,deaddocno);

grant select on dead_t to tiptop;
grant update on dead_t to tiptop;
grant delete on dead_t to tiptop;
grant insert on dead_t to tiptop;

exit;
