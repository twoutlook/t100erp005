/* 
================================================================================
檔案代號:mhbk_t
檔案名稱:圖紙呈現內容設定檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table mhbk_t
(
mhbkent       number(5)      ,/* 企業編號 */
mhbk001       varchar2(10)      ,/* 分類碼 */
mhbk002       number(10,0)      ,/* 順序 */
mhbk003       varchar2(20)      ,/* 欄位編號 */
mhbk004       varchar2(1)      ,/* 圖紙呈現 */
mhbk005       varchar2(1)      ,/* 提示呈現 */
mhbkownid       varchar2(20)      ,/* 資料所有者 */
mhbkowndp       varchar2(10)      ,/* 資料所屬部門 */
mhbkcrtid       varchar2(20)      ,/* 資料建立者 */
mhbkcrtdp       varchar2(10)      ,/* 資料建立部門 */
mhbkcrtdt       timestamp(0)      ,/* 資料創建日 */
mhbkmodid       varchar2(20)      ,/* 資料修改者 */
mhbkmoddt       timestamp(0)      ,/* 最近修改日 */
mhbkstus       varchar2(10)      ,/* 狀態碼 */
mhbkud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
mhbkud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
mhbkud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
mhbkud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
mhbkud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
mhbkud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
mhbkud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
mhbkud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
mhbkud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
mhbkud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
mhbkud011       number(20,6)      ,/* 自定義欄位(數字)011 */
mhbkud012       number(20,6)      ,/* 自定義欄位(數字)012 */
mhbkud013       number(20,6)      ,/* 自定義欄位(數字)013 */
mhbkud014       number(20,6)      ,/* 自定義欄位(數字)014 */
mhbkud015       number(20,6)      ,/* 自定義欄位(數字)015 */
mhbkud016       number(20,6)      ,/* 自定義欄位(數字)016 */
mhbkud017       number(20,6)      ,/* 自定義欄位(數字)017 */
mhbkud018       number(20,6)      ,/* 自定義欄位(數字)018 */
mhbkud019       number(20,6)      ,/* 自定義欄位(數字)019 */
mhbkud020       number(20,6)      ,/* 自定義欄位(數字)020 */
mhbkud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
mhbkud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
mhbkud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
mhbkud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
mhbkud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
mhbkud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
mhbkud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
mhbkud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
mhbkud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
mhbkud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table mhbk_t add constraint mhbk_pk primary key (mhbkent,mhbk001,mhbk002) enable validate;

create unique index mhbk_pk on mhbk_t (mhbkent,mhbk001,mhbk002);

grant select on mhbk_t to tiptop;
grant update on mhbk_t to tiptop;
grant delete on mhbk_t to tiptop;
grant insert on mhbk_t to tiptop;

exit;
