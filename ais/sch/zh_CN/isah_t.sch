/* 
================================================================================
檔案代號:isah_t
檔案名稱:銷項發票明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table isah_t
(
isahent       number(5)      ,/* 企業編號 */
isahcomp       varchar2(10)      ,/* 法人 */
isahdocno       varchar2(20)      ,/* 開票單號 */
isahseq       number(10,0)      ,/* 項次 */
isahorga       varchar2(10)      ,/* 來源組織 */
isah001       varchar2(20)      ,/* 發票代碼 */
isah002       varchar2(20)      ,/* 發票號碼 */
isah003       varchar2(40)      ,/* 貨物或應稅勞務編碼 */
isah004       varchar2(255)      ,/* 貨物或應稅勞務名稱 */
isah005       varchar2(10)      ,/* 發票單位 */
isah006       number(20,6)      ,/* 發票數量 */
isah007       number(5,2)      ,/* 稅率 */
isah008       varchar2(20)      ,/* 原始發票代碼 */
isah009       varchar2(20)      ,/* 原始發票號碼 */
isah010       number(5,0)      ,/* 正負值 */
isah101       number(20,6)      ,/* 發票單價 */
isah103       number(20,6)      ,/* 發票原幣稅前金額 */
isah104       number(20,6)      ,/* 發票原幣稅額 */
isah105       number(20,6)      ,/* 發票原幣稅後金額 */
isah113       number(20,6)      ,/* 發票本幣稅前金額 */
isah114       number(20,6)      ,/* 發票本幣稅額 */
isah115       number(20,6)      ,/* 發票本幣稅後金額 */
isahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
isahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
isahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
isahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
isahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
isahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
isahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
isahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
isahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
isahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
isahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
isahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
isahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
isahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
isahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
isahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
isahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
isahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
isahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
isahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
isahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
isahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
isahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
isahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
isahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
isahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
isahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
isahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
isahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
isahud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
isah011       number(10,0)      ,/* 發票分群 */
isah012       varchar2(255)      ,/* 備註 */
isah013       varchar2(255)      ,/* 規格 */
isah106       number(20,6)      ,/* 原幣折扣金額 */
isah116       number(20,6)      /* 本幣折扣金額 */
);
alter table isah_t add constraint isah_pk primary key (isahent,isahcomp,isahdocno,isahseq) enable validate;

create  index isah_n1 on isah_t (isahent,isahcomp,isah001,isah002);
create unique index isah_pk on isah_t (isahent,isahcomp,isahdocno,isahseq);

grant select on isah_t to tiptop;
grant update on isah_t to tiptop;
grant delete on isah_t to tiptop;
grant insert on isah_t to tiptop;

exit;
