/* 
================================================================================
檔案代號:ooig_t
檔案名稱:單據款別範圍設定作業
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table ooig_t
(
ooigent       number(5)      ,/* 企業編號 */
ooigstus       varchar2(10)      ,/* 有效否 */
ooig001       varchar2(20)      ,/* 作業編號 */
ooig002       varchar2(10)      ,/* 款別性質 */
ooig003       varchar2(10)      ,/* 對應POS作業 */
ooigpos       varchar2(1)      ,/* 下傳否 */
ooigstamp       timestamp(5)      ,/* 時間戳記 */
ooigownid       varchar2(20)      ,/* 資料所有者 */
ooigowndp       varchar2(10)      ,/* 資料所屬部門 */
ooigcrtid       varchar2(20)      ,/* 資料建立者 */
ooigcrtdp       varchar2(10)      ,/* 資料建立部門 */
ooigcrtdt       timestamp(0)      ,/* 資料創建日 */
ooigmodid       varchar2(20)      ,/* 資料修改者 */
ooigmoddt       timestamp(0)      ,/* 最近修改日 */
ooigud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
ooigud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
ooigud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
ooigud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
ooigud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
ooigud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
ooigud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
ooigud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
ooigud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
ooigud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
ooigud011       number(20,6)      ,/* 自定義欄位(數字)011 */
ooigud012       number(20,6)      ,/* 自定義欄位(數字)012 */
ooigud013       number(20,6)      ,/* 自定義欄位(數字)013 */
ooigud014       number(20,6)      ,/* 自定義欄位(數字)014 */
ooigud015       number(20,6)      ,/* 自定義欄位(數字)015 */
ooigud016       number(20,6)      ,/* 自定義欄位(數字)016 */
ooigud017       number(20,6)      ,/* 自定義欄位(數字)017 */
ooigud018       number(20,6)      ,/* 自定義欄位(數字)018 */
ooigud019       number(20,6)      ,/* 自定義欄位(數字)019 */
ooigud020       number(20,6)      ,/* 自定義欄位(數字)020 */
ooigud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
ooigud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
ooigud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
ooigud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
ooigud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
ooigud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
ooigud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
ooigud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
ooigud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
ooigud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table ooig_t add constraint ooig_pk primary key (ooigent,ooig001,ooig002) enable validate;

create unique index ooig_pk on ooig_t (ooigent,ooig001,ooig002);

grant select on ooig_t to tiptop;
grant update on ooig_t to tiptop;
grant delete on ooig_t to tiptop;
grant insert on ooig_t to tiptop;

exit;
