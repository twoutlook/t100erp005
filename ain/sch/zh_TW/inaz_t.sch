/* 
================================================================================
檔案代號:inaz_t
檔案名稱:inao_t的克隆,为中间TABLE,为了加速批序号 r.a中的处理
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table inaz_t
(
inazent       number(5)      ,/* 企業代碼 */
inazsite       varchar2(10)      ,/* 營運據點 */
inazdocno       varchar2(20)      ,/* 單號 */
inazseq       number(10,0)      ,/* 項次 */
inazseq1       number(10,0)      ,/* 項序 */
inazseq2       number(10,0)      ,/* 序號 */
inaz000       varchar2(1)      ,/* 資料類型 */
inaz001       varchar2(40)      ,/* 料件編號 */
inaz002       varchar2(256)      ,/* 產品特徵 */
inaz003       varchar2(30)      ,/* 庫存管理特徵 */
inaz004       varchar2(40)      ,/* 包裝容器編號 */
inaz005       varchar2(10)      ,/* 庫位 */
inaz006       varchar2(10)      ,/* 儲位 */
inaz007       varchar2(30)      ,/* 批號 */
inaz008       varchar2(30)      ,/* 製造批號 */
inaz009       varchar2(30)      ,/* 製造序號 */
inaz010       date      ,/* 製造日期 */
inaz011       date      ,/* 有效日期 */
inaz012       number(20,6)      ,/* 數量 */
inaz013       number(5,0)      ,/* 出入庫碼 */
inazud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
inazud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
inazud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
inazud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
inazud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
inazud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
inazud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
inazud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
inazud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
inazud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
inazud011       number(20,6)      ,/* 自定義欄位(數字)011 */
inazud012       number(20,6)      ,/* 自定義欄位(數字)012 */
inazud013       number(20,6)      ,/* 自定義欄位(數字)013 */
inazud014       number(20,6)      ,/* 自定義欄位(數字)014 */
inazud015       number(20,6)      ,/* 自定義欄位(數字)015 */
inazud016       number(20,6)      ,/* 自定義欄位(數字)016 */
inazud017       number(20,6)      ,/* 自定義欄位(數字)017 */
inazud018       number(20,6)      ,/* 自定義欄位(數字)018 */
inazud019       number(20,6)      ,/* 自定義欄位(數字)019 */
inazud020       number(20,6)      ,/* 自定義欄位(數字)020 */
inazud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
inazud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
inazud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
inazud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
inazud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
inazud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
inazud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
inazud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
inazud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
inazud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table inaz_t add constraint inaz_pk primary key (inazent,inazsite,inazdocno,inazseq,inazseq1,inazseq2,inaz000) enable validate;

create unique index inaz_pk on inaz_t (inazent,inazsite,inazdocno,inazseq,inazseq1,inazseq2,inaz000);

grant select on inaz_t to tiptop;
grant update on inaz_t to tiptop;
grant delete on inaz_t to tiptop;
grant insert on inaz_t to tiptop;

exit;
