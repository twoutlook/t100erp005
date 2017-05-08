/* 
================================================================================
檔案代號:bgbk_t
檔案名稱:預算挪用單頭檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:T
多語系檔案:N
============.========================.==========================================
 */
create table bgbk_t
(
bgbkent       number(5)      ,/* 企業代碼 */
bgbkdocdt       date      ,/* 申請挪用日期 */
bgbkdocno       varchar2(20)      ,/* 單號 */
bgbk001       varchar2(10)      ,/* 預算編號 */
bgbk002       varchar2(10)      ,/* 預算版本 */
bgbk003       varchar2(10)      ,/* 預算組織 */
bgbk004       varchar2(255)      ,/* 摘要 */
bgbkstus       varchar2(10)      ,/* 狀態碼 */
bgbkownid       varchar2(20)      ,/* 資料所有者 */
bgbkowndp       varchar2(10)      ,/* 資料所屬部門 */
bgbkcrtid       varchar2(20)      ,/* 資料建立者 */
bgbkcrtdp       varchar2(10)      ,/* 資料建立部門 */
bgbkcrtdt       timestamp(0)      ,/* 資料創建日 */
bgbkmodid       varchar2(20)      ,/* 資料修改者 */
bgbkmoddt       timestamp(0)      ,/* 最近修改日 */
bgbkcnfid       varchar2(20)      ,/* 資料確認者 */
bgbkcnfdt       timestamp(0)      ,/* 資料確認日 */
bgbkpstid       varchar2(20)      ,/* 資料過帳者 */
bgbkpstdt       timestamp(0)      ,/* 資料過帳日 */
bgbkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
bgbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
bgbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
bgbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
bgbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
bgbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
bgbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
bgbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
bgbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
bgbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
bgbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
bgbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
bgbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
bgbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
bgbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
bgbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
bgbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
bgbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
bgbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
bgbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
bgbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
bgbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
bgbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
bgbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
bgbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
bgbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
bgbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
bgbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
bgbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
bgbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table bgbk_t add constraint bgbk_pk primary key (bgbkent,bgbkdocno) enable validate;

create unique index bgbk_pk on bgbk_t (bgbkent,bgbkdocno);

grant select on bgbk_t to tiptop;
grant update on bgbk_t to tiptop;
grant delete on bgbk_t to tiptop;
grant insert on bgbk_t to tiptop;

exit;
