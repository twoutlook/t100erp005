/* 
================================================================================
檔案代號:deai_t
檔案名稱:門店收銀繳款單身檔-發票資料
檔案目的: 
上游檔案:
下游檔案:
檔案類型:D
多語系檔案:N
============.========================.==========================================
 */
create table deai_t
(
deaient       number(5)      ,/* 企業編號 */
deaisite       varchar2(10)      ,/* 營運據點 */
deaiunit       varchar2(10)      ,/* 應用組織 */
deaidocno       varchar2(20)      ,/* 單據編號 */
deai001       varchar2(1)      ,/* 類別 */
deai002       varchar2(20)      ,/* 發票起號 */
deai003       varchar2(20)      ,/* 發票迄號 */
deai004       number(20,6)      ,/* 未稅金額 */
deai005       number(20,6)      ,/* 含稅金額 */
deaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
deaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
deaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
deaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
deaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
deaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
deaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
deaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
deaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
deaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
deaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
deaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
deaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
deaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
deaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
deaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
deaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
deaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
deaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
deaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
deaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
deaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
deaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
deaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
deaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
deaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
deaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
deaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
deaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
deaiud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table deai_t add constraint deai_pk primary key (deaient,deaidocno,deai001,deai002) enable validate;

create unique index deai_pk on deai_t (deaient,deaidocno,deai001,deai002);

grant select on deai_t to tiptop;
grant update on deai_t to tiptop;
grant delete on deai_t to tiptop;
grant insert on deai_t to tiptop;

exit;
