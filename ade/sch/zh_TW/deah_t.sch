/* 
================================================================================
檔案代號:deah_t
檔案名稱:門店收銀繳款單身檔-收銀資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deah_t
(
deahent       number(5)      ,/* 企業編號 */
deahsite       varchar2(10)      ,/* 營運據點 */
deahunit       varchar2(10)      ,/* 應用組織 */
deahdocno       varchar2(20)      ,/* 單據編號 */
deahseq       number(10,0)      ,/* 項次 */
deah000       varchar2(10)      ,/* 款別分類 */
deah001       varchar2(10)      ,/* 款別編號 */
deah002       varchar2(10)      ,/* 卡種/券種編號 */
deah003       varchar2(10)      ,/* 券種面額編號 */
deah004       number(20,6)      ,/* 單位金額 */
deah005       varchar2(10)      ,/* 幣別 */
deah006       number(20,10)      ,/* 匯率 */
deah007       number(20,6)      ,/* 數量 */
deah008       number(20,6)      ,/* 金額 */
deah009       varchar2(20)      ,/* 支票號碼 */
deah010       number(20,6)      ,/* 找零金額 */
deah011       number(20,6)      ,/* 溢收金額 */
deah012       number(15,3)      ,/* 抵現積分 */
deah013       number(20,6)      ,/* 本幣金額 */
deah014       date      ,/* 審帳完成日 */
deah015       number(20,6)      ,/* 差異金額 */
deahud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deahud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deahud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deahud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deahud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deahud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deahud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deahud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deahud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deahud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deahud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deahud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deahud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deahud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deahud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deahud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deahud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deahud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deahud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deahud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deahud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deahud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deahud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deahud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deahud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deahud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deahud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deahud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deahud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deahud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deah_t add constraint deah_pk primary key (deahent,deahdocno,deahseq) enable validate;

create unique index deah_pk on deah_t (deahent,deahdocno,deahseq);

grant select on deah_t to tiptop;
grant update on deah_t to tiptop;
grant delete on deah_t to tiptop;
grant insert on deah_t to tiptop;

exit;
