/* 
================================================================================
檔案代號:pmdg_t
檔案名稱:詢價單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table pmdg_t
(
pmdgent       number(5)      ,/* 企業編號 */
pmdgsite       varchar2(10)      ,/* 營運據點 */
pmdgdocno       varchar2(20)      ,/* 詢價單號 */
pmdgseq       number(10,0)      ,/* 項次 */
pmdg001       varchar2(1)      ,/* 委外否 */
pmdg002       varchar2(10)      ,/* 供應商編號 */
pmdg003       varchar2(40)      ,/* 料件編號 */
pmdg004       varchar2(256)      ,/* 產品特徵 */
pmdg005       varchar2(40)      ,/* 包裝容器 */
pmdg007       number(20,6)      ,/* 詢價數量 */
pmdg008       varchar2(10)      ,/* 詢價單位 */
pmdg009       varchar2(1)      ,/* 分量計價否 */
pmdg010       number(20,6)      ,/* 單價 */
pmdg011       number(5,2)      ,/* 稅率 */
pmdg012       number(20,6)      ,/* 折扣率 */
pmdg013       number(20,6)      ,/* 最低採購量 */
pmdg014       varchar2(10)      ,/* 作業編號 */
pmdg015       varchar2(10)      ,/* 作業序 */
pmdg016       varchar2(10)      ,/* 運輸方式 */
pmdg017       date      ,/* 有效日期 */
pmdg018       varchar2(10)      ,/* 稅別 */
pmdg030       varchar2(255)      ,/* 備註 */
pmdgud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
pmdgud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
pmdgud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
pmdgud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
pmdgud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
pmdgud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
pmdgud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
pmdgud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
pmdgud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
pmdgud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
pmdgud011       number(20,6)      ,/* 自定義欄位(數字)011 */
pmdgud012       number(20,6)      ,/* 自定義欄位(數字)012 */
pmdgud013       number(20,6)      ,/* 自定義欄位(數字)013 */
pmdgud014       number(20,6)      ,/* 自定義欄位(數字)014 */
pmdgud015       number(20,6)      ,/* 自定義欄位(數字)015 */
pmdgud016       number(20,6)      ,/* 自定義欄位(數字)016 */
pmdgud017       number(20,6)      ,/* 自定義欄位(數字)017 */
pmdgud018       number(20,6)      ,/* 自定義欄位(數字)018 */
pmdgud019       number(20,6)      ,/* 自定義欄位(數字)019 */
pmdgud020       number(20,6)      ,/* 自定義欄位(數字)020 */
pmdgud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
pmdgud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
pmdgud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
pmdgud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
pmdgud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
pmdgud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
pmdgud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
pmdgud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
pmdgud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
pmdgud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table pmdg_t add constraint pmdg_pk primary key (pmdgent,pmdgdocno,pmdgseq) enable validate;

create unique index pmdg_pk on pmdg_t (pmdgent,pmdgdocno,pmdgseq);

grant select on pmdg_t to tiptop;
grant update on pmdg_t to tiptop;
grant delete on pmdg_t to tiptop;
grant insert on pmdg_t to tiptop;

exit;
