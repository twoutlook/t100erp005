/* 
================================================================================
檔案代號:mrdk_t
檔案名稱:資源維修工單報工單單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table mrdk_t
(
mrdkent       number(5)      ,/* 企業編號 */
mrdksite       varchar2(10)      ,/* 營運據點 */
mrdkdocno       varchar2(20)      ,/* 報工單號 */
mrdkseq       number(10,0)      ,/* 項次 */
mrdk001       varchar2(20)      ,/* 維修工單單號 */
mrdk002       varchar2(20)      ,/* 資源編號 */
mrdk003       varchar2(20)      ,/* 原廠序號 */
mrdk004       number(20,6)      ,/* 維修數量 */
mrdk005       date      ,/* 維修後資源除役日期 */
mrdk006       number(10,0)      ,/* 維修後資源使用次數 */
mrdk007       varchar2(10)      ,/* 維修後資源狀態 */
mrdkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mrdkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mrdkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mrdkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mrdkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mrdkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mrdkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mrdkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mrdkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mrdkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mrdkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mrdkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mrdkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mrdkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mrdkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mrdkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mrdkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mrdkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mrdkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mrdkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mrdkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mrdkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mrdkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mrdkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mrdkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mrdkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mrdkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mrdkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mrdkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mrdkud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
mrdk008       number(10,0)      ,/* 預計延長資源使用天數 */
mrdk009       number(10,0)      /* 預計增加資源使用次數 */
);
alter table mrdk_t add constraint mrdk_pk primary key (mrdkent,mrdkdocno,mrdkseq) enable validate;

create unique index mrdk_pk on mrdk_t (mrdkent,mrdkdocno,mrdkseq);

grant select on mrdk_t to tiptop;
grant update on mrdk_t to tiptop;
grant delete on mrdk_t to tiptop;
grant insert on mrdk_t to tiptop;

exit;
