/* 
================================================================================
檔案代號:mrdg_t
檔案名稱:資源歸還單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrdg_t
(
mrdgent       number(5)      ,/* 企業編號 */
mrdgsite       varchar2(10)      ,/* 營運據點 */
mrdgdocno       varchar2(20)      ,/* 資源歸還單號 */
mrdgseq       number(10,0)      ,/* 項次 */
mrdg001       varchar2(20)      ,/* 來源單號 */
mrdg002       number(10,0)      ,/* 來源項次 */
mrdg003       varchar2(20)      ,/* 資源編號 */
mrdg004       number(20,6)      ,/* 數量 */
mrdg005       varchar2(20)      ,/* 參考單號 */
mrdg006       varchar2(10)      ,/* 參考作業編號 */
mrdg007       varchar2(20)      ,/* 參考機器編號 */
mrdg008       number(10,0)      ,/* 使用次數 */
mrdg009       number(15,3)      ,/* 使用時間 */
mrdg010       varchar2(10)      ,/* 歸還方式 */
mrdg011       varchar2(10)      ,/* 還回狀態 */
mrdg012       number(20,6)      ,/* 償還金額 */
mrdg013       varchar2(255)      ,/* 備註 */
mrdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdgud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mrdg014       varchar2(10)      /* 幣別 */
);
alter table mrdg_t add constraint mrdg_pk primary key (mrdgent,mrdgdocno,mrdgseq) enable validate;

create unique index mrdg_pk on mrdg_t (mrdgent,mrdgdocno,mrdgseq);

grant select on mrdg_t to tiptop;
grant update on mrdg_t to tiptop;
grant delete on mrdg_t to tiptop;
grant insert on mrdg_t to tiptop;

exit;
