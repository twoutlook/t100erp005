/* 
================================================================================
檔案代號:imeg_t
檔案名稱:規則化規格設定資料檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imeg_t
(
imegent       number(5)      ,/* 企業編號 */
imegownid       varchar2(20)      ,/* 資料所有者 */
imegowndp       varchar2(10)      ,/* 資料所屬部門 */
imegcrtid       varchar2(20)      ,/* 資料建立者 */
imegcrtdp       varchar2(10)      ,/* 資料建立部門 */
imegcrtdt       timestamp(0)      ,/* 資料創建日 */
imegmodid       varchar2(20)      ,/* 資料修改者 */
imegmoddt       timestamp(0)      ,/* 最近修改日 */
imegstus       varchar2(10)      ,/* 狀態碼 */
imeg001       varchar2(10)      ,/* 規格種類 */
imeg002       varchar2(255)      ,/* 案例 */
imeg003       varchar2(10)      ,/* 節點編號 */
imeg004       varchar2(10)      ,/* 前段節點編號 */
imeg005       number(5,0)      ,/* 段次 */
imeg006       varchar2(10)      ,/* 節點型態 */
imeg007       varchar2(40)      ,/* 規格固定值 */
imeg008       varchar2(10)      ,/* 人工輸入檢查類型 */
imeg009       number(5,0)      ,/* 人工輸入文字長度 */
imeg010       varchar2(40)      ,/* 人工輸入數值格式 */
imeg011       varchar2(20)      ,/* 人工輸入數值下限 */
imeg012       varchar2(20)      ,/* 人工輸入數值上限 */
imegud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imegud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imegud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imegud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imegud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imegud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imegud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imegud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imegud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imegud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imegud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imegud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imegud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imegud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imegud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imegud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imegud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imegud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imegud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imegud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imegud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imegud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imegud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imegud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imegud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imegud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imegud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imegud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imegud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imegud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imeg_t add constraint imeg_pk primary key (imegent,imeg001,imeg003) enable validate;

create unique index imeg_pk on imeg_t (imegent,imeg001,imeg003);

grant select on imeg_t to tiptop;
grant update on imeg_t to tiptop;
grant delete on imeg_t to tiptop;
grant insert on imeg_t to tiptop;

exit;
