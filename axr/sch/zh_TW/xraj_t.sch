/* 
================================================================================
檔案代號:xraj_t
檔案名稱:款別會計科目設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table xraj_t
(
xrajent       number(5)      ,/* 企業編號 */
xrajownid       varchar2(20)      ,/* 資料所有者 */
xrajowndp       varchar2(10)      ,/* 資料所屬部門 */
xrajcrtid       varchar2(20)      ,/* 資料建立者 */
xrajcrtdp       varchar2(10)      ,/* 資料建立部門 */
xrajcrtdt       timestamp(0)      ,/* 資料創建日 */
xrajmodid       varchar2(20)      ,/* 資料修改者 */
xrajmoddt       timestamp(0)      ,/* 最近修改日 */
xrajstus       varchar2(10)      ,/* 狀態碼 */
xrajsite       varchar2(10)      ,/* 營運據點 */
xraj001       varchar2(10)      ,/* 帳套編號 */
xraj002       varchar2(10)      ,/* 款別編號 */
xraj003       varchar2(1)      ,/* 會計科目設計畫面 */
xrajud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
xrajud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
xrajud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
xrajud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
xrajud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
xrajud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
xrajud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
xrajud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
xrajud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
xrajud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
xrajud011       number(20,6)      ,/* 自定義欄位(數字)011 */
xrajud012       number(20,6)      ,/* 自定義欄位(數字)012 */
xrajud013       number(20,6)      ,/* 自定義欄位(數字)013 */
xrajud014       number(20,6)      ,/* 自定義欄位(數字)014 */
xrajud015       number(20,6)      ,/* 自定義欄位(數字)015 */
xrajud016       number(20,6)      ,/* 自定義欄位(數字)016 */
xrajud017       number(20,6)      ,/* 自定義欄位(數字)017 */
xrajud018       number(20,6)      ,/* 自定義欄位(數字)018 */
xrajud019       number(20,6)      ,/* 自定義欄位(數字)019 */
xrajud020       number(20,6)      ,/* 自定義欄位(數字)020 */
xrajud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
xrajud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
xrajud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
xrajud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
xrajud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
xrajud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
xrajud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
xrajud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
xrajud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
xrajud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table xraj_t add constraint xraj_pk primary key (xrajent,xraj001,xraj002) enable validate;

create unique index xraj_pk on xraj_t (xrajent,xraj001,xraj002);

grant select on xraj_t to tiptop;
grant update on xraj_t to tiptop;
grant delete on xraj_t to tiptop;
grant insert on xraj_t to tiptop;

exit;
