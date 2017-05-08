/* 
================================================================================
檔案代號:imai_t
檔案名稱:料件據點資訊檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:M
多語系檔案:N
============.========================.==========================================
 */
create table imai_t
(
imaient       number(5)      ,/* 企業編號 */
imaisite       varchar2(10)      ,/* 營運據點 */
imai001       varchar2(40)      ,/* 料件編號 */
imai021       number(20,6)      ,/* 最近採購單價 */
imai022       number(20,6)      ,/* 平均採購單價 */
imai023       number(20,6)      ,/* 採購市價 */
imai024       date      ,/* 最近採購市價異動日 */
imai025       date      ,/* 期間採購最近採購日 */
imai026       number(20,6)      ,/* 最近詢價單價 */
imai031       date      ,/* 首次出庫日 */
imai032       date      ,/* 首次入庫日 */
imai033       date      ,/* 最近出庫日 */
imai034       date      ,/* 最近入庫日 */
imai035       date      ,/* 最近採購日 */
imai036       date      ,/* 最近異動日 */
imai037       date      ,/* 最近呆滯日 */
imai051       varchar2(10)      ,/* 產品檢核狀態 */
imai052       varchar2(20)      ,/* 產品最後修改者 */
imai053       timestamp(0)      ,/* 產品最後修改日期 */
imai054       varchar2(10)      ,/* 庫存檢核狀態 */
imai055       varchar2(20)      ,/* 庫存最後修改者 */
imai056       timestamp(0)      ,/* 庫存最後修改日期 */
imai057       varchar2(10)      ,/* 銷售檢核狀態 */
imai058       varchar2(20)      ,/* 銷售最後修改者 */
imai059       timestamp(0)      ,/* 銷售最後修改日期 */
imai060       varchar2(10)      ,/* 採購檢核狀態 */
imai061       varchar2(20)      ,/* 採購最後修改者 */
imai062       timestamp(0)      ,/* 採購最後修改日期 */
imai063       varchar2(10)      ,/* 生管檢核狀態 */
imai064       varchar2(20)      ,/* 生管最後修改者 */
imai065       timestamp(0)      ,/* 生管最後修改日期 */
imai066       varchar2(10)      ,/* 品管檢核狀態 */
imai067       varchar2(20)      ,/* 品管最後修改者 */
imai068       timestamp(0)      ,/* 品管最後修改日期 */
imai069       varchar2(10)      ,/* 成本檢核狀態 */
imai070       varchar2(20)      ,/* 成本最後修改者 */
imai071       timestamp(0)      ,/* 成本最後修改日期 */
imaiownid       varchar2(20)      ,/* 資料所有者 */
imaiowndp       varchar2(10)      ,/* 資料所屬部門 */
imaicrtid       varchar2(20)      ,/* 資料建立者 */
imaicrtdp       varchar2(10)      ,/* 資料建立部門 */
imaicrtdt       timestamp(0)      ,/* 資料創建日 */
imaimodid       varchar2(20)      ,/* 資料修改者 */
imaimoddt       timestamp(0)      ,/* 最近修改日 */
imaicnfid       varchar2(20)      ,/* 資料確認者 */
imaicnfdt       timestamp(0)      ,/* 資料確認日 */
imaistus       varchar2(10)      ,/* 狀態碼 */
imai038       date      ,/* 最近周期盤點日 */
imai039       date      ,/* 最近會計盤點日 */
imai101       date      ,/* 最近採購單價更新日期 */
imai102       varchar2(20)      ,/* 最近採購單價來源單號 */
imai106       timestamp(0)      ,/* 平均採購單價上次計算時間 */
imai112       varchar2(20)      ,/* 採購市價來源單號 */
imai116       date      ,/* 最近詢價單價更新日期 */
imai117       varchar2(20)      ,/* 最近詢價單價來源單號 */
imai131       date      ,/* 最近核價更新日期 */
imai132       varchar2(20)      ,/* 最近核價來源單號 */
imai201       date      ,/* 最近銷售單價更新日期 */
imai202       varchar2(20)      ,/* 最近銷售單價來源單號 */
imai212       varchar2(20)      ,/* 銷售市價來源單號 */
imai216       date      ,/* 最近報價更新日期 */
imai217       varchar2(20)      ,/* 最近報價來源單號 */
imai221       number(20,6)      ,/* 最近銷售單價 */
imai222       number(20,6)      ,/* 平均銷售單價 */
imai223       number(20,6)      ,/* 銷售市價 */
imai224       date      ,/* 銷售市價更新日期 */
imai231       date      ,/* 最近出貨更新日期 */
imai232       varchar2(20)      ,/* 最近出貨來源單號 */
imai251       date      ,/* 首次量產日 */
imai252       varchar2(20)      ,/* 工單單號 */
imai256       date      ,/* 首批檢驗日 */
imai257       varchar2(20)      ,/* FQC單號 */
imai261       date      ,/* 首次入庫日 */
imai262       varchar2(20)      ,/* 入庫單號 */
imai266       number(20,6)      ,/* 累積生產量 */
imai267       number(20,6)      ,/* 累積產出量 */
imai268       number(20,6)      ,/* 累積良率 */
imaiud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
imaiud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
imaiud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
imaiud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
imaiud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
imaiud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
imaiud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
imaiud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
imaiud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
imaiud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
imaiud011       number(20,6)      ,/* 自定義欄位(數字)011 */
imaiud012       number(20,6)      ,/* 自定義欄位(數字)012 */
imaiud013       number(20,6)      ,/* 自定義欄位(數字)013 */
imaiud014       number(20,6)      ,/* 自定義欄位(數字)014 */
imaiud015       number(20,6)      ,/* 自定義欄位(數字)015 */
imaiud016       number(20,6)      ,/* 自定義欄位(數字)016 */
imaiud017       number(20,6)      ,/* 自定義欄位(數字)017 */
imaiud018       number(20,6)      ,/* 自定義欄位(數字)018 */
imaiud019       number(20,6)      ,/* 自定義欄位(數字)019 */
imaiud020       number(20,6)      ,/* 自定義欄位(數字)020 */
imaiud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
imaiud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
imaiud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
imaiud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
imaiud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
imaiud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
imaiud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
imaiud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
imaiud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
imaiud030       timestamp(0)      ,/* 自定義欄位(日期時間)030 */
imai072       varchar2(10)      ,/* 關務檢核狀態 */
imai073       varchar2(20)      ,/* 關務最後修改者 */
imai074       date      /* 關務最後修改日期 */
);
alter table imai_t add constraint imai_pk primary key (imaient,imaisite,imai001) enable validate;

create unique index imai_pk on imai_t (imaient,imaisite,imai001);

grant select on imai_t to tiptop;
grant update on imai_t to tiptop;
grant delete on imai_t to tiptop;
grant insert on imai_t to tiptop;

exit;
