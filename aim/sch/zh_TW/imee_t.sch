/* 
================================================================================
檔案代號:imee_t
檔案名稱:規則化品名種類檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table imee_t
(
imeeent       number(5)      ,/* 企業編號 */
imeeownid       varchar2(20)      ,/* 資料所有者 */
imeeowndp       varchar2(10)      ,/* 資料所屬部門 */
imeecrtid       varchar2(20)      ,/* 資料建立者 */
imeecrtdp       varchar2(10)      ,/* 資料建立部門 */
imeecrtdt       timestamp(0)      ,/* 資料創建日 */
imeemodid       varchar2(20)      ,/* 資料修改者 */
imeemoddt       timestamp(0)      ,/* 最近修改日 */
imeestus       varchar2(10)      ,/* 狀態碼 */
imee001       varchar2(10)      ,/* 品名種類 */
imee002       varchar2(255)      ,/* 案例 */
imee003       varchar2(10)      ,/* 節點編號 */
imee004       varchar2(10)      ,/* 前段節點編號 */
imee005       number(5,0)      ,/* 段次 */
imee006       varchar2(10)      ,/* 節點型態 */
imee007       varchar2(40)      ,/* 品名固定值 */
imee008       varchar2(10)      ,/* 人工輸入檢查類型 */
imee009       number(5,0)      ,/* 人工輸入文字長度 */
imee010       varchar2(40)      ,/* 人工輸入數值格式 */
imee011       varchar2(20)      ,/* 人工輸入數值下限 */
imee012       varchar2(20)      ,/* 人工輸入數值上限 */
imeeud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imeeud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imeeud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imeeud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imeeud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imeeud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imeeud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imeeud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imeeud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imeeud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imeeud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imeeud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imeeud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imeeud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imeeud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imeeud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imeeud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imeeud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imeeud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imeeud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imeeud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imeeud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imeeud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imeeud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imeeud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imeeud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imeeud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imeeud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imeeud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imeeud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table imee_t add constraint imee_pk primary key (imeeent,imee001,imee003) enable validate;

create unique index imee_pk on imee_t (imeeent,imee001,imee003);

grant select on imee_t to tiptop;
grant update on imee_t to tiptop;
grant delete on imee_t to tiptop;
grant insert on imee_t to tiptop;

exit;
