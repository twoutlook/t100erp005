/* 
================================================================================
檔案代號:pmca_t
檔案名稱:供應商證照異動單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table pmca_t
(
pmcaent       number(5)      ,/* 企業編號 */
pmcadocno       varchar2(20)      ,/* 單號 */
pmcadocdt       date      ,/* 單據日期 */
pmca001       varchar2(1)      ,/* 作業方式 */
pmca002       varchar2(20)      ,/* 異動人員 */
pmca003       varchar2(10)      ,/* 異動部門 */
pmcaownid       varchar2(20)      ,/* 資料所有者 */
pmcaowndp       varchar2(10)      ,/* 資料所屬部門 */
pmcacrtid       varchar2(20)      ,/* 資料建立者 */
pmcacrtdp       varchar2(10)      ,/* 資料建立部門 */
pmcacrtdt       timestamp(0)      ,/* 資料創建日 */
pmcamodid       varchar2(20)      ,/* 資料修改者 */
pmcamoddt       timestamp(0)      ,/* 最近修改日 */
pmcacnfid       varchar2(20)      ,/* 資料確認者 */
pmcacnfdt       timestamp(0)      ,/* 資料確認日 */
pmcastus       varchar2(10)      ,/* 狀態碼 */
pmcaud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmcaud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmcaud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmcaud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmcaud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmcaud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmcaud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmcaud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmcaud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmcaud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmcaud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmcaud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmcaud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmcaud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmcaud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmcaud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmcaud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmcaud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmcaud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmcaud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmcaud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmcaud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmcaud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmcaud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmcaud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmcaud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmcaud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmcaud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmcaud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmcaud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmca_t add constraint pmca_pk primary key (pmcaent,pmcadocno) enable validate;

create unique index pmca_pk on pmca_t (pmcaent,pmcadocno);

grant select on pmca_t to tiptop;
grant update on pmca_t to tiptop;
grant delete on pmca_t to tiptop;
grant insert on pmca_t to tiptop;

exit;
