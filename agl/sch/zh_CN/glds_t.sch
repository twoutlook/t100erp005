/* 
================================================================================
檔案代號:glds_t
檔案名稱:合併報表長期投資成本法轉權益法維護單身檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table glds_t
(
gldsent       number(5)      ,/* 企業編號 */
gldsld       varchar2(5)      ,/* 合併帳套 */
glds001       varchar2(10)      ,/* 投資公司 */
glds002       number(5,0)      ,/* 年度 */
glds003       number(5,0)      ,/* 期別 */
glds004       varchar2(10)      ,/* 被投資公司 */
glds005       varchar2(5)      ,/* 個體帳套 */
glds006       varchar2(24)      ,/* 所有者權益科目 */
glds007       number(20,6)      ,/* 借方總額(記帳幣) */
glds008       number(20,6)      ,/* 貸方總額(記帳幣) */
glds009       number(20,6)      ,/* 借方總額(功能幣) */
glds010       number(20,6)      ,/* 貸方總額(功能幣) */
glds011       number(20,6)      ,/* 借方總額(報告幣) */
glds012       number(20,6)      ,/* 貸方總額(報告幣) */
glds013       number(20,6)      ,/* 投資比例 */
glds014       varchar2(24)      ,/* 投資公司股權科目 */
glds015       number(20,6)      ,/* 投資公司權益借方總額(記帳幣) */
glds016       number(20,6)      ,/* 投資公司權益貸方總額(記帳幣) */
glds017       number(20,6)      ,/* 投資公司權益借方總額(功能幣) */
glds018       number(20,6)      ,/* 投資公司權益貸方總額(功能幣) */
glds019       number(20,6)      ,/* 投資公司權益借方總額(報告幣) */
glds020       number(20,6)      ,/* 投資公司權益貸方總額(報告幣) */
gldsud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gldsud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gldsud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gldsud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gldsud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gldsud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gldsud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gldsud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gldsud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gldsud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gldsud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gldsud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gldsud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gldsud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gldsud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gldsud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gldsud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gldsud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gldsud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gldsud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gldsud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gldsud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gldsud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gldsud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gldsud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gldsud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gldsud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gldsud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gldsud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gldsud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glds_t add constraint glds_pk primary key (gldsent,gldsld,glds001,glds002,glds003,glds004,glds006) enable validate;

create unique index glds_pk on glds_t (gldsent,gldsld,glds001,glds002,glds003,glds004,glds006);

grant select on glds_t to tiptop;
grant update on glds_t to tiptop;
grant delete on glds_t to tiptop;
grant insert on glds_t to tiptop;

exit;
