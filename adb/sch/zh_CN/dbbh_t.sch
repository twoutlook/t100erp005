/* 
================================================================================
檔案代號:dbbh_t
檔案名稱:配送倉庫出貨範圍設置-門店範圍
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table dbbh_t
(
dbbhent       number(5)      ,/* 企業代碼 */
dbbhsite       varchar2(10)      ,/* 營運據點 */
dbbh001       varchar2(10)      ,/* 庫位編號 */
dbbh002       varchar2(10)      ,/* 門店編號 */
dbbhownid       varchar2(20)      ,/* 資料所有者 */
dbbhowndp       varchar2(10)      ,/* 資料所屬部門 */
dbbhcrtid       varchar2(20)      ,/* 資料建立者 */
dbbhcrtdp       varchar2(10)      ,/* 資料建立部門 */
dbbhcrtdt       timestamp(0)      ,/* 資料創建日 */
dbbhmodid       varchar2(20)      ,/* 資料修改者 */
dbbhmoddt       timestamp(0)      ,/* 最近修改日 */
dbbhstus       varchar2(10)      ,/* 狀態碼 */
dbbhud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
dbbhud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
dbbhud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
dbbhud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
dbbhud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
dbbhud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
dbbhud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
dbbhud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
dbbhud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
dbbhud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
dbbhud011       number(20,6)      ,/* 自定義欄位(數字)011 */
dbbhud012       number(20,6)      ,/* 自定義欄位(數字)012 */
dbbhud013       number(20,6)      ,/* 自定義欄位(數字)013 */
dbbhud014       number(20,6)      ,/* 自定義欄位(數字)014 */
dbbhud015       number(20,6)      ,/* 自定義欄位(數字)015 */
dbbhud016       number(20,6)      ,/* 自定義欄位(數字)016 */
dbbhud017       number(20,6)      ,/* 自定義欄位(數字)017 */
dbbhud018       number(20,6)      ,/* 自定義欄位(數字)018 */
dbbhud019       number(20,6)      ,/* 自定義欄位(數字)019 */
dbbhud020       number(20,6)      ,/* 自定義欄位(數字)020 */
dbbhud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
dbbhud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
dbbhud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
dbbhud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
dbbhud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
dbbhud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
dbbhud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
dbbhud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
dbbhud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
dbbhud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table dbbh_t add constraint dbbh_pk primary key (dbbhent,dbbhsite,dbbh001,dbbh002) enable validate;

create unique index dbbh_pk on dbbh_t (dbbhent,dbbhsite,dbbh001,dbbh002);

grant select on dbbh_t to tiptop;
grant update on dbbh_t to tiptop;
grant delete on dbbh_t to tiptop;
grant insert on dbbh_t to tiptop;

exit;
