/* 
================================================================================
檔案代號:stcd_t
檔案名稱:分銷合約申請經營範圍設定表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stcd_t
(
stcdent       number(5)      ,/* 企業編號 */
stcdsite       varchar2(10)      ,/* 營運據點 */
stcdunit       varchar2(10)      ,/* 應用組織 */
stcddocno       varchar2(20)      ,/* 單號 */
stcdseq       number(10,0)      ,/* 項次 */
stcd001       varchar2(20)      ,/* 合約編號 */
stcd002       varchar2(10)      ,/* 品類/品牌編號 */
stcd003       varchar2(1)      ,/* 可退貨否 */
stcdud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stcdud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stcdud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stcdud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stcdud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stcdud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stcdud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stcdud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stcdud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stcdud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stcdud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stcdud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stcdud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stcdud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stcdud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stcdud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stcdud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stcdud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stcdud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stcdud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stcdud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stcdud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stcdud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stcdud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stcdud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stcdud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stcdud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stcdud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stcdud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stcdud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stcd_t add constraint stcd_pk primary key (stcdent,stcddocno,stcdseq) enable validate;

create unique index stcd_pk on stcd_t (stcdent,stcddocno,stcdseq);

grant select on stcd_t to tiptop;
grant update on stcd_t to tiptop;
grant delete on stcd_t to tiptop;
grant insert on stcd_t to tiptop;

exit;
