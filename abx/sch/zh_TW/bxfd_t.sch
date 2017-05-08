/* 
================================================================================
檔案代號:bxfd_t
檔案名稱:銷售預測資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table bxfd_t
(
bxfdent       number(5)      ,/* 企業編號 */
bxfdsite       varchar2(10)      ,/* 營運據點 */
bxfd001       varchar2(10)      ,/* 區分 */
bxfd002       date      ,/* 銷售日期from */
bxfd003       varchar2(40)      ,/* 料件編號 */
bxfd004       number(20,6)      ,/* 數量 */
bxfd005       date      ,/* 銷售日期to */
bxfdownid       varchar2(20)      ,/* 資料所有者 */
bxfdowndp       varchar2(10)      ,/* 資料所屬部門 */
bxfdcrtid       varchar2(20)      ,/* 資料建立者 */
bxfdcrtdp       varchar2(10)      ,/* 資料建立部門 */
bxfdcrtdt       timestamp(0)      ,/* 資料創建日 */
bxfdmodid       varchar2(20)      ,/* 資料修改者 */
bxfdmoddt       timestamp(0)      ,/* 最近修改日 */
bxfdcnfid       varchar2(20)      ,/* 資料確認者 */
bxfdcnfdt       timestamp(0)      ,/* 資料確認日 */
bxfdstus       varchar2(10)      ,/* 狀態碼 */
bxfdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bxfdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bxfdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bxfdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bxfdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bxfdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bxfdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bxfdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bxfdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bxfdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bxfdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bxfdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bxfdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bxfdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bxfdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bxfdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bxfdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bxfdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bxfdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bxfdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bxfdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bxfdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bxfdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bxfdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bxfdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bxfdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bxfdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bxfdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bxfdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bxfdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bxfd_t add constraint bxfd_pk primary key (bxfdent,bxfdsite,bxfd001,bxfd003) enable validate;

create unique index bxfd_pk on bxfd_t (bxfdent,bxfdsite,bxfd001,bxfd003);

grant select on bxfd_t to tiptop;
grant update on bxfd_t to tiptop;
grant delete on bxfd_t to tiptop;
grant insert on bxfd_t to tiptop;

exit;
