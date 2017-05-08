/* 
================================================================================
檔案代號:infe_t
檔案名稱:貨架商品關係申請明細表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table infe_t
(
infeent       number(5)      ,/* 企業編號 */
infesite       varchar2(10)      ,/* 營運據點 */
infeunit       varchar2(10)      ,/* 應用組織 */
infedocno       varchar2(20)      ,/* 單據編號 */
infeseq       number(10,0)      ,/* 項次 */
infeseq1       number(10,0)      ,/* 序號 */
infe001       varchar2(40)      ,/* 商品編碼 */
infe002       varchar2(40)      ,/* 商品條碼 */
infe003       varchar2(256)      ,/* 商品特征 */
infe004       varchar2(10)      ,/* 庫存單位 */
infe005       varchar2(10)      ,/* 貨架編號 */
infe006       varchar2(10)      ,/* 貨架類型 */
infe007       number(5,0)      ,/* 開始層 */
infe008       number(5,0)      ,/* 結束層 */
infe009       number(5,0)      ,/* 開始列 */
infe010       number(5,0)      ,/* 結束列 */
infe011       number(5,0)      ,/* 排面數量 */
infe012       number(5,0)      ,/* 最小陳列量 */
infe013       number(5,0)      ,/* 最大陳列量 */
infe014       number(5,0)      ,/* 最小庫存 */
infe015       number(20,6)      ,/* 當前庫存 */
infe016       number(5,0)      ,/* 單層層板陳列數 */
infe017       number(5,0)      ,/* 單層層板層數 */
infeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
infeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
infeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
infeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
infeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
infeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
infeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
infeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
infeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
infeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
infeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
infeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
infeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
infeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
infeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
infeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
infeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
infeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
infeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
infeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
infeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
infeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
infeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
infeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
infeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
infeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
infeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
infeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
infeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
infeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table infe_t add constraint infe_pk primary key (infeent,infedocno,infeseq,infeseq1) enable validate;

create unique index infe_pk on infe_t (infeent,infedocno,infeseq,infeseq1);

grant select on infe_t to tiptop;
grant update on infe_t to tiptop;
grant delete on infe_t to tiptop;
grant insert on infe_t to tiptop;

exit;
