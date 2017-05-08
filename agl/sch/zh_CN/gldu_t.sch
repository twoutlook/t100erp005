/* 
================================================================================
檔案代號:gldu_t
檔案名稱:合併報表關係人交易資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gldu_t
(
glduent       number(5)      ,/* 企業編號 */
glduld       varchar2(5)      ,/* 合併帳套 */
gldu001       varchar2(10)      ,/* 上層公司編號 */
gldu002       varchar2(5)      ,/* 上層公司帳套 */
gldu003       number(5,0)      ,/* 年度 */
gldu004       number(5,0)      ,/* 期別 */
gldu005       varchar2(10)      ,/* 幣別(記帳幣) */
gldu006       varchar2(10)      ,/* 幣別(功能幣) */
gldu007       varchar2(10)      ,/* 幣別(報告幣) */
gldu008       varchar2(20)      ,/* 調整傳票單號 */
gldu009       number(10,0)      ,/* 項次 */
gldu010       varchar2(1)      ,/* 交易類別 */
gldu011       varchar2(10)      ,/* 來源公司 */
gldu012       varchar2(5)      ,/* 來源公司帳套 */
gldu013       varchar2(10)      ,/* 交易公司 */
gldu014       varchar2(5)      ,/* 交易公司帳套 */
gldu015       varchar2(24)      ,/* 內部交易收入科目 */
gldu016       varchar2(24)      ,/* 內部交易成本科目 */
gldu017       varchar2(24)      ,/* 未實現損益科目 */
gldu018       number(20,6)      ,/* 內部交易收入(記帳幣) */
gldu019       number(20,6)      ,/* 內部交易收入(功能幣) */
gldu020       number(20,6)      ,/* 內部交易收入(報告幣) */
gldu021       number(20,6)      ,/* 交易損益(記帳幣) */
gldu022       number(20,6)      ,/* 交易損益(功能幣) */
gldu023       number(20,6)      ,/* 交易損益(報告幣) */
gldu024       number(20,6)      ,/* 己實現損益(記帳幣) */
gldu025       number(20,6)      ,/* 己實現損益(功能幣) */
gldu026       number(20,6)      ,/* 己實現損益(報告幣) */
gldu027       number(20,6)      ,/* 未實現損益(記帳幣) */
gldu028       number(20,6)      ,/* 未實現損益(功能幣) */
gldu029       number(20,6)      ,/* 未實現損益(報告幣) */
glduownid       varchar2(20)      ,/* 資料所有者 */
glduowndp       varchar2(10)      ,/* 資料所屬部門 */
glducrtid       varchar2(20)      ,/* 資料建立者 */
glducrtdp       varchar2(10)      ,/* 資料建立部門 */
glducrtdt       timestamp(0)      ,/* 資料創建日 */
gldumodid       varchar2(20)      ,/* 資料修改者 */
gldumoddt       timestamp(0)      ,/* 最近修改日 */
glducnfid       varchar2(20)      ,/* 資料確認者 */
glducnfdt       timestamp(0)      ,/* 資料確認日 */
gldustus       varchar2(10)      ,/* 狀態碼 */
glduud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glduud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glduud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glduud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glduud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glduud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glduud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glduud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glduud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glduud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glduud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glduud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glduud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glduud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glduud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glduud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glduud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glduud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glduud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glduud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glduud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glduud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glduud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glduud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glduud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glduud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glduud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glduud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glduud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glduud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gldu_t add constraint gldu_pk primary key (glduent,glduld,gldu001,gldu002,gldu003,gldu004,gldu009) enable validate;

create unique index gldu_pk on gldu_t (glduent,glduld,gldu001,gldu002,gldu003,gldu004,gldu009);

grant select on gldu_t to tiptop;
grant update on gldu_t to tiptop;
grant delete on gldu_t to tiptop;
grant insert on gldu_t to tiptop;

exit;
