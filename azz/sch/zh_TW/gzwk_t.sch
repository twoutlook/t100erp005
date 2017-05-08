/* 
================================================================================
檔案代號:gzwk_t
檔案名稱:FAQ及公告紀錄主表
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table gzwk_t
(
gzwkownid       varchar2(20)      ,/* 資料所有者 */
gzwkowndp       varchar2(10)      ,/* 資料所屬部門 */
gzwkcrtid       varchar2(20)      ,/* 資料建立者 */
gzwkcrtdp       varchar2(10)      ,/* 資料建立部門 */
gzwkcrtdt       timestamp(0)      ,/* 資料創建日 */
gzwkmodid       varchar2(20)      ,/* 資料修改者 */
gzwkmoddt       timestamp(0)      ,/* 最近修改日 */
gzwkcnfid       varchar2(20)      ,/* 資料確認者 */
gzwkcnfdt       timestamp(0)      ,/* 資料確認日 */
gzwkstus       varchar2(10)      ,/* 狀態碼 */
gzwk001       number(5,0)      ,/* 編號 */
gzwk002       varchar2(10)      ,/* 分類 */
gzwk003       varchar2(80)      ,/* FAQ問題 */
gzwk004       varchar2(1000)      ,/* 問題補充敘述 */
gzwk005       varchar2(20)      ,/* 提出員工編號 */
gzwk006       clob      ,/* FAQ回覆 */
gzwk007       varchar2(20)      ,/* FAQ回覆員工編號 */
gzwk008       varchar2(1)      ,/* 重要公告或重要FAQ */
gzwk009       timestamp(0)      ,/* 提出時間 */
gzwk010       timestamp(0)      ,/* 回覆時間 */
gzwkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
gzwkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
gzwkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
gzwkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
gzwkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
gzwkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
gzwkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
gzwkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
gzwkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
gzwkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
gzwkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
gzwkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
gzwkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
gzwkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
gzwkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
gzwkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
gzwkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
gzwkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
gzwkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
gzwkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
gzwkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
gzwkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
gzwkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
gzwkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
gzwkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
gzwkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
gzwkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
gzwkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
gzwkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
gzwkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table gzwk_t add constraint gzwk_pk primary key (gzwk001) enable validate;

create unique index gzwk_pk on gzwk_t (gzwk001);

grant select on gzwk_t to tiptop;
grant update on gzwk_t to tiptop;
grant delete on gzwk_t to tiptop;
grant insert on gzwk_t to tiptop;

exit;
