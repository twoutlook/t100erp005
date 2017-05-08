/* 
================================================================================
檔案代號:infn_t
檔案名稱:隨貨同行單單身檔-單據編號匯總
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infn_t
(
infnent       number(5)      ,/* 企業編號 */
infnsite       varchar2(10)      ,/* 營運據點 */
infnunit       varchar2(10)      ,/* 應用組織 */
infndocno       varchar2(20)      ,/* 隨貨同行單號 */
infnseq       number(10,0)      ,/* 項次 */
infn001       varchar2(10)      ,/* 來源類別 */
infn002       varchar2(20)      ,/* 來源單號 */
infnud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infnud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infnud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infnud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infnud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infnud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infnud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infnud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infnud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infnud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infnud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infnud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infnud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infnud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infnud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infnud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infnud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infnud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infnud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infnud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infnud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infnud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infnud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infnud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infnud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infnud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infnud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infnud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infnud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infnud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infn_t add constraint infn_pk primary key (infnent,infndocno,infnseq) enable validate;

create unique index infn_pk on infn_t (infnent,infndocno,infnseq);

grant select on infn_t to tiptop;
grant update on infn_t to tiptop;
grant delete on infn_t to tiptop;
grant insert on infn_t to tiptop;

exit;
