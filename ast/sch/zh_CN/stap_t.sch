/* 
================================================================================
檔案代號:stap_t
檔案名稱:自營合約費用分段扣率設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table stap_t
(
stapent       number(5)      ,/* 企業編號 */
stap001       varchar2(20)      ,/* 合約編號 */
stap002       number(10,0)      ,/* 項次1 */
stap003       number(10,0)      ,/* 項次2 */
stap004       number(20,6)      ,/* 起始金額 */
stap005       number(20,6)      ,/* 截止金額 */
stap006       number(20,6)      ,/* 扣率 */
stapud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
stapud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
stapud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
stapud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
stapud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
stapud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
stapud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
stapud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
stapud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
stapud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
stapud011       number(20,6)      ,/* 自定義欄位(數字)011 */
stapud012       number(20,6)      ,/* 自定義欄位(數字)012 */
stapud013       number(20,6)      ,/* 自定義欄位(數字)013 */
stapud014       number(20,6)      ,/* 自定義欄位(數字)014 */
stapud015       number(20,6)      ,/* 自定義欄位(數字)015 */
stapud016       number(20,6)      ,/* 自定義欄位(數字)016 */
stapud017       number(20,6)      ,/* 自定義欄位(數字)017 */
stapud018       number(20,6)      ,/* 自定義欄位(數字)018 */
stapud019       number(20,6)      ,/* 自定義欄位(數字)019 */
stapud020       number(20,6)      ,/* 自定義欄位(數字)020 */
stapud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
stapud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
stapud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
stapud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
stapud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
stapud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
stapud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
stapud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
stapud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
stapud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table stap_t add constraint stap_pk primary key (stapent,stap001,stap002,stap003) enable validate;

create unique index stap_pk on stap_t (stapent,stap001,stap002,stap003);

grant select on stap_t to tiptop;
grant update on stap_t to tiptop;
grant delete on stap_t to tiptop;
grant insert on stap_t to tiptop;

exit;
