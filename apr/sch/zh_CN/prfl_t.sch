/* 
================================================================================
檔案代號:prfl_t
檔案名稱:客戶定價明細資料表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table prfl_t
(
prflent       number(5)      ,/* 企業編號 */
prflunit       varchar2(10)      ,/* 應用組織 */
prflsite       varchar2(10)      ,/* 營運據點 */
prfldocno       varchar2(20)      ,/* 申請單號 */
prflseq       number(10,0)      ,/* 項次 */
prfl001       varchar2(40)      ,/* 產品編號 */
prfl002       varchar2(10)      ,/* 幣別 */
prfl003       varchar2(10)      ,/* 稅別 */
prfl004       date      ,/* 生效日期 */
prfl005       date      ,/* 失效日期 */
prfl006       varchar2(10)      ,/* 計價單位 */
prfl007       number(20,6)      ,/* 成本價 */
prfl008       number(20,6)      ,/* 出廠價 */
prfl009       number(20,6)      ,/* 毛利率 */
prfl010       number(20,6)      ,/* 批發價 */
prfl011       number(20,6)      ,/* 市場價 */
prfl012       number(20,6)      ,/* 常規配贈 */
prfl013       number(20,6)      ,/* 導購提成 */
prfl014       varchar2(40)      ,/* 產品條碼 */
prflud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
prflud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
prflud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
prflud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
prflud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
prflud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
prflud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
prflud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
prflud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
prflud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
prflud011       number(20,6)      ,/* 自定義欄位(數字)011 */
prflud012       number(20,6)      ,/* 自定義欄位(數字)012 */
prflud013       number(20,6)      ,/* 自定義欄位(數字)013 */
prflud014       number(20,6)      ,/* 自定義欄位(數字)014 */
prflud015       number(20,6)      ,/* 自定義欄位(數字)015 */
prflud016       number(20,6)      ,/* 自定義欄位(數字)016 */
prflud017       number(20,6)      ,/* 自定義欄位(數字)017 */
prflud018       number(20,6)      ,/* 自定義欄位(數字)018 */
prflud019       number(20,6)      ,/* 自定義欄位(數字)019 */
prflud020       number(20,6)      ,/* 自定義欄位(數字)020 */
prflud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
prflud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
prflud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
prflud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
prflud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
prflud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
prflud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
prflud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
prflud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
prflud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table prfl_t add constraint prfl_pk primary key (prflent,prfldocno,prflseq) enable validate;

create unique index prfl_pk on prfl_t (prflent,prfldocno,prflseq);

grant select on prfl_t to tiptop;
grant update on prfl_t to tiptop;
grant delete on prfl_t to tiptop;
grant insert on prfl_t to tiptop;

exit;
