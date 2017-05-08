/* 
================================================================================
檔案代號:deap_t
檔案名稱:營業款寄送存繳單明細檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table deap_t
(
deapent       number(5)      ,/* 企業編號 */
deapsite       varchar2(10)      ,/* 營運據點 */
deapunit       varchar2(10)      ,/* 應用組織 */
deapdocno       varchar2(20)      ,/* 存繳單號 */
deapseq       number(10,0)      ,/* 項次 */
deap001       date      ,/* 營業日期 */
deap002       varchar2(10)      ,/* 款別分類 */
deap003       varchar2(10)      ,/* 款別編號 */
deap004       varchar2(10)      ,/* 券種編號 */
deap005       varchar2(10)      ,/* 券面額編號 */
deap006       varchar2(10)      ,/* 幣別 */
deap007       number(20,6)      ,/* 代收數量 */
deap008       number(20,6)      ,/* 代收金額 */
deapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deap_t add constraint deap_pk primary key (deapent,deapdocno,deapseq) enable validate;

create unique index deap_pk on deap_t (deapent,deapdocno,deapseq);

grant select on deap_t to tiptop;
grant update on deap_t to tiptop;
grant delete on deap_t to tiptop;
grant insert on deap_t to tiptop;

exit;
