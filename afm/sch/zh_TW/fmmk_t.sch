/* 
================================================================================
檔案代號:fmmk_t
檔案名稱:購買費用檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table fmmk_t
(
fmmkent       number(5)      ,/* 企業編號 */
fmmk001       varchar2(20)      ,/* 投資購買單號 */
fmmk002       number(10,0)      ,/* 項次 */
fmmk003       varchar2(10)      ,/* 費用類型 */
fmmk004       varchar2(10)      ,/* 幣別 */
fmmk005       number(20,6)      ,/* 金額 */
fmmk006       varchar2(1)      ,/* 使用資金帳戶 */
fmmk007       varchar2(20)      ,/* NO USE */
fmmk008       number(10,0)      ,/* NO USE */
fmmk009       number(20,10)      ,/* 匯率 */
fmmkownid       varchar2(20)      ,/* 資料所有者 */
fmmkowndp       varchar2(10)      ,/* 資料所屬部門 */
fmmkcrtid       varchar2(20)      ,/* 資料建立者 */
fmmkcrtdp       varchar2(10)      ,/* 資料建立部門 */
fmmkcrtdt       timestamp(0)      ,/* 資料創建日 */
fmmkmodid       varchar2(20)      ,/* 資料修改者 */
fmmkmoddt       timestamp(0)      ,/* 最近修改日 */
fmmkcnfid       varchar2(20)      ,/* 資料確認者 */
fmmkcnfdt       timestamp(0)      ,/* 資料確認日 */
fmmkpstid       varchar2(20)      ,/* 資料過帳者 */
fmmkpstdt       timestamp(0)      ,/* 資料過帳日 */
fmmkstus       varchar2(10)      ,/* 狀態碼 */
fmmkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
fmmkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
fmmkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
fmmkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
fmmkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
fmmkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
fmmkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
fmmkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
fmmkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
fmmkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
fmmkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
fmmkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
fmmkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
fmmkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
fmmkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
fmmkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
fmmkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
fmmkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
fmmkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
fmmkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
fmmkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
fmmkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
fmmkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
fmmkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
fmmkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
fmmkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
fmmkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
fmmkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
fmmkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
fmmkud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
fmmk010       varchar2(10)      ,/* 存提碼 */
fmmk011       varchar2(10)      ,/* 現金變動碼 */
fmmk012       varchar2(10)      ,/* 銀行帳戶 */
fmmk013       number(20,6)      /* 本幣金額 */
);
alter table fmmk_t add constraint fmmk_pk primary key (fmmkent,fmmk001,fmmk002) enable validate;

create unique index fmmk_pk on fmmk_t (fmmkent,fmmk001,fmmk002);

grant select on fmmk_t to tiptop;
grant update on fmmk_t to tiptop;
grant delete on fmmk_t to tiptop;
grant insert on fmmk_t to tiptop;

exit;
