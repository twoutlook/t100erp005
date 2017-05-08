/* 
================================================================================
檔案代號:infj_t
檔案名稱:貨架商品調整明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infj_t
(
infjent       number(5)      ,/* 企業編號 */
infjsite       varchar2(10)      ,/* 營運據點 */
infjunit       varchar2(10)      ,/* 應用組織 */
infjdocno       varchar2(20)      ,/* 單據編號 */
infjseq       number(10,0)      ,/* 項次 */
infj001       varchar2(40)      ,/* 商品編碼 */
infj002       varchar2(40)      ,/* 商品條碼 */
infj003       varchar2(256)      ,/* 商品特征 */
infj004       varchar2(10)      ,/* 庫存單位 */
infj005       varchar2(10)      ,/* 貨架編號 */
infj006       number(20,6)      ,/* 調整前數量 */
infj007       number(20,6)      ,/* 調整數量 */
infj008       number(20,6)      ,/* 調整後數量 */
infjud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infjud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infjud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infjud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infjud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infjud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infjud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infjud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infjud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infjud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infjud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infjud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infjud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infjud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infjud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infjud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infjud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infjud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infjud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infjud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infjud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infjud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infjud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infjud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infjud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infjud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infjud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infjud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infjud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infjud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infj_t add constraint infj_pk primary key (infjent,infjdocno,infjseq) enable validate;

create unique index infj_pk on infj_t (infjent,infjdocno,infjseq);

grant select on infj_t to tiptop;
grant update on infj_t to tiptop;
grant delete on infj_t to tiptop;
grant insert on infj_t to tiptop;

exit;
